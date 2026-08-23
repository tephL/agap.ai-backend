import { query, withTransaction } from "#/services/db.mjs";

// ------------------------------------------------------------------
// Teams
// ------------------------------------------------------------------

export async function getTeams() {
    const text = `
        SELECT team_id, name, contact_number, location_text,
               latitude AS lat, longitude AS lng, status, created_at
        FROM team
        ORDER BY created_at DESC;`;
    const result = await query(text);
    return result.rows;
}

export async function getTeamById(team_id) {
    const text = `
        SELECT team_id, name, contact_number, location_text,
               latitude AS lat, longitude AS lng, status, created_at
        FROM team
        WHERE team_id = $1;`;
    const result = await query(text, [team_id]);
    return result.rows[0] ?? null;
}

export async function createTeam({ name, contact_number, location_text, latitude, longitude }) {
    const text = `
        INSERT INTO team (name, contact_number, location_text, latitude, longitude)
        VALUES ($1, $2, $3, $4, $5)
        RETURNING team_id, name, contact_number, location_text,
                  latitude AS lat, longitude AS lng, status, created_at;`;
    const values = [name, contact_number ?? null, location_text ?? null, latitude ?? null, longitude ?? null];
    const result = await query(text, values);
    return result.rows[0];
}

// ------------------------------------------------------------------
// Clusters
// ------------------------------------------------------------------

export async function getClusters({ status } = {}) {
    const text = `
        SELECT cluster_id, name, latitude AS lat, longitude AS lng, priority,
               status, report_count, people_affected, ai_summary, action_plan
        FROM cluster
        ${status ? "WHERE status = $1" : ""}
        ORDER BY
            CASE priority WHEN 'high' THEN 0 WHEN 'medium' THEN 1 ELSE 2 END,
            report_count DESC;`;
    const result = await query(text, status ? [status] : []);
    return result.rows;
}

export async function setClusterStatus(cluster_id, status) {
    const text = `
        UPDATE cluster
        SET status = $2, updated_at = now()
        WHERE cluster_id = $1
        RETURNING cluster_id, name, latitude AS lat, longitude AS lng, priority,
                  status, report_count, people_affected, ai_summary, action_plan;`;
    const result = await query(text, [cluster_id, status]);
    return result.rows[0] ?? null;
}

// ------------------------------------------------------------------
// Assignments
// ------------------------------------------------------------------

function assignmentSelect(where = "") {
    return `
        SELECT a.assignment_id, a.team_id, a.cluster_id, a.status,
               a.created_at, a.updated_at,
               c.name          AS c_name,
               c.latitude      AS c_lat,
               c.longitude     AS c_lng,
               c.priority      AS c_priority,
               c.status        AS c_status,
               c.report_count  AS c_report_count,
               c.people_affected AS c_people_affected
        FROM assignment a
        JOIN cluster c ON c.cluster_id = a.cluster_id
        ${where}`;
}

function shapeAssignment(row) {
    if (!row) return null;
    return {
        assignment_id: row.assignment_id,
        team_id: row.team_id,
        cluster_id: row.cluster_id,
        status: row.status,
        created_at: row.created_at,
        updated_at: row.updated_at,
        cluster: {
            cluster_id: row.cluster_id,
            name: row.c_name,
            lat: row.c_lat,
            lng: row.c_lng,
            priority: row.c_priority,
            status: row.c_status,
            report_count: row.c_report_count,
            people_affected: row.c_people_affected,
        },
    };
}

// Most relevant assignment for a team: the active one if any,
// otherwise the most recently updated (e.g. last resolved run).
export async function getAssignmentForTeam(team_id) {
    const text = assignmentSelect("WHERE a.team_id = $1") + `
        ORDER BY CASE WHEN a.status <> 'resolved' THEN 0 ELSE 1 END,
                 a.updated_at DESC
        LIMIT 1;`;
    const result = await query(text, [team_id]);
    return shapeAssignment(result.rows[0]);
}

export async function createAssignment({ team_id, cluster_id }) {
    return withTransaction(async (client) => {
        const team = await client.query(
            `SELECT team_id FROM team WHERE team_id = $1 FOR UPDATE;`,
            [team_id]
        );
        if (team.rowCount === 0) {
            const err = new Error("Team not found");
            err.statusCode = 404;
            throw err;
        }

        const cluster = await client.query(
            `SELECT cluster_id, status FROM cluster WHERE cluster_id = $1;`,
            [cluster_id]
        );
        if (cluster.rowCount === 0) {
            const err = new Error("Cluster not found");
            err.statusCode = 404;
            throw err;
        }

        const active = await client.query(
            `SELECT assignment_id FROM assignment
             WHERE team_id = $1 AND status <> 'resolved'
             LIMIT 1;`,
            [team_id]
        );
        if (active.rowCount > 0) {
            const err = new Error("Team already has an active assignment");
            err.statusCode = 409;
            throw err;
        }

        const inserted = await client.query(
            `INSERT INTO assignment (team_id, cluster_id)
             VALUES ($1, $2)
             RETURNING assignment_id;`,
            [team_id, cluster_id]
        );

        // Dispatching means the team is on the clock.
        await client.query(
            `UPDATE team SET status = 'busy' WHERE team_id = $1;`,
            [team_id]
        );

        const full = await client.query(assignmentSelect("WHERE a.assignment_id = $1"), [
            inserted.rows[0].assignment_id,
        ]);
        return shapeAssignment(full.rows[0]);
    });
}

export async function updateAssignmentStatus(assignment_id, status) {
    return withTransaction(async (client) => {
        const current = await client.query(
            `SELECT assignment_id, team_id, status FROM assignment WHERE assignment_id = $1 FOR UPDATE;`,
            [assignment_id]
        );
        if (current.rowCount === 0) {
            const err = new Error("Assignment not found");
            err.statusCode = 404;
            throw err;
        }
        const { team_id } = current.rows[0];

        const updated = await client.query(
            `UPDATE assignment SET status = $2, updated_at = now()
             WHERE assignment_id = $1
             RETURNING assignment_id;`,
            [assignment_id, status]
        );

        if (status === "resolved") {
            const stillBusy = await client.query(
                `SELECT 1 FROM assignment
                 WHERE team_id = $1 AND status <> 'resolved'
                 LIMIT 1;`,
                [team_id]
            );
            if (stillBusy.rowCount === 0) {
                await client.query(
                    `UPDATE team SET status = 'available' WHERE team_id = $1;`,
                    [team_id]
                );
            }
        } else {
            // pending/dispatched keep the team busy.
            await client.query(
                `UPDATE team SET status = 'busy' WHERE team_id = $1;`,
                [team_id]
            );
        }

        const full = await client.query(assignmentSelect("WHERE a.assignment_id = $1"), [
            updated.rows[0].assignment_id,
        ]);
        return shapeAssignment(full.rows[0]);
    });
}
