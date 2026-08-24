import { query, withTransaction } from "#/services/db.mjs";

// ------------------------------------------------------------------
// Teams
// ------------------------------------------------------------------
//
// Live schema notes (sql/schema.sql):
// - teams has no status column; availability is derived from
//   assigned_to (the cluster it is responding to) and archived_at.
// - teams has no location_text; the city name from cities is used.
// Every read/write is scoped to one city so dispatchers only ever see
// and touch teams from their own city.

const TEAM_SELECT = `
    SELECT t.team_id, t.name, t.contact_number,
           ci.name AS location_text,
           t.latitude AS lat, t.longitude AS lng,
           CASE
               WHEN t.archived_at IS NOT NULL THEN 'offline'
               WHEN t.assigned_to IS NOT NULL THEN 'busy'
               ELSE 'available'
           END AS status,
           t.created_at
    FROM teams t
    LEFT JOIN cities ci ON ci.city_id = t.city_id`;

export async function getTeams(city_id) {
    const text = `
        ${TEAM_SELECT}
        WHERE t.city_id = $1 AND t.archived_at IS NULL
        ORDER BY t.created_at DESC;`;
    const result = await query(text, [city_id]);
    return result.rows;
}

export async function getTeamById(team_id, city_id) {
    const text = `
        ${TEAM_SELECT}
        WHERE t.team_id = $1 AND t.city_id = $2 AND t.archived_at IS NULL;`;
    const result = await query(text, [team_id, city_id]);
    return result.rows[0] ?? null;
}

export async function createTeam({ name, contact_number, latitude, longitude }, city_id) {
    const text = `
        WITH new_team AS (
            INSERT INTO teams (name, contact_number, latitude, longitude, city_id)
            VALUES ($1, $2, $3, $4, $5)
            RETURNING team_id, name, contact_number, latitude, longitude, created_at, city_id
        )
        SELECT nt.team_id, nt.name, nt.contact_number,
               ci.name AS location_text,
               nt.latitude AS lat, nt.longitude AS lng,
               'available' AS status,
               nt.created_at
        FROM new_team nt
        LEFT JOIN cities ci ON ci.city_id = nt.city_id;`;
    const values = [name, contact_number ?? null, latitude ?? null, longitude ?? null, city_id];
    const result = await query(text, values);
    return result.rows[0];
}

// ------------------------------------------------------------------
// Clusters
// ------------------------------------------------------------------

// Clusters carry priority_level (not priority) and have no name column,
// so a display label is synthesized for the UI. Scoped to the
// dispatcher's city, same as /api/clusters on the reports side.
const CLUSTER_SELECT = `
    SELECT cluster_id,
           CONCAT('Cluster #', cluster_id) AS name,
           latitude AS lat, longitude AS lng,
           priority_level AS priority,
           status, report_count, people_affected, ai_summary, action_plan
    FROM clusters`;

export async function getClusters({ status } = {}, city_id) {
    const text = `
        ${CLUSTER_SELECT}
        WHERE city_id = $1 ${status ? "AND status = $2" : ""}
        ORDER BY
            CASE priority_level WHEN 'high' THEN 0 WHEN 'medium' THEN 1 ELSE 2 END,
            report_count DESC;`;
    const result = await query(text, status ? [city_id, status] : [city_id]);
    return result.rows;
}

export async function setClusterStatus(cluster_id, status, city_id) {
    const text = `
        UPDATE clusters
        SET status = $2, updated_at = now()
        WHERE cluster_id = $1 AND city_id = $3
        RETURNING cluster_id,
                  CONCAT('Cluster #', cluster_id) AS name,
                  latitude AS lat, longitude AS lng,
                  priority_level AS priority,
                  status, report_count, people_affected, ai_summary, action_plan;`;
    const result = await query(text, [cluster_id, status, city_id]);
    return result.rows[0] ?? null;
}

// ------------------------------------------------------------------
// Assignments
// ------------------------------------------------------------------

function assignmentSelect(where = "") {
    return `
        SELECT a.assignment_id, a.team_id, a.cluster_id, a.status,
               a.created_at, a.updated_at,
               CONCAT('Cluster #', c.cluster_id) AS c_name,
               c.latitude      AS c_lat,
               c.longitude     AS c_lng,
               c.priority_level AS c_priority,
               c.status        AS c_status,
               c.report_count  AS c_report_count,
               c.people_affected AS c_people_affected
        FROM assignment a
        JOIN clusters c ON c.cluster_id = a.cluster_id
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

export async function createAssignment({ team_id, cluster_id }, city_id) {
    return withTransaction(async (client) => {
        // City checks double as the scope guard: a dispatcher can only
        // pair teams and clusters that both live in their own city.
        const team = await client.query(
            `SELECT team_id, city_id FROM teams
             WHERE team_id = $1 AND archived_at IS NULL FOR UPDATE;`,
            [team_id]
        );
        if (team.rowCount === 0 || team.rows[0].city_id !== city_id) {
            const err = new Error("Team not found");
            err.statusCode = 404;
            throw err;
        }

        const cluster = await client.query(
            `SELECT cluster_id FROM clusters WHERE cluster_id = $1 AND city_id = $2;`,
            [cluster_id, city_id]
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
            `UPDATE teams SET assigned_to = $2 WHERE team_id = $1;`,
            [team_id, cluster_id]
        );

        const full = await client.query(assignmentSelect("WHERE a.assignment_id = $1"), [
            inserted.rows[0].assignment_id,
        ]);
        return shapeAssignment(full.rows[0]);
    });
}

export async function updateAssignmentStatus(assignment_id, status, city_id) {
    return withTransaction(async (client) => {
        const current = await client.query(
            `SELECT a.assignment_id, a.team_id, a.cluster_id
             FROM assignment a
             JOIN teams t ON t.team_id = a.team_id
             WHERE a.assignment_id = $1 AND t.city_id = $2
             FOR UPDATE OF a;`,
            [assignment_id, city_id]
        );
        if (current.rowCount === 0) {
            const err = new Error("Assignment not found");
            err.statusCode = 404;
            throw err;
        }
        const { team_id, cluster_id } = current.rows[0];

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
                    `UPDATE teams SET assigned_to = NULL WHERE team_id = $1;`,
                    [team_id]
                );
            }
        } else {
            // pending/dispatched keep the team tied to its cluster.
            await client.query(
                `UPDATE teams SET assigned_to = $2 WHERE team_id = $1;`,
                [team_id, cluster_id]
            );
        }

        const full = await client.query(assignmentSelect("WHERE a.assignment_id = $1"), [
            updated.rows[0].assignment_id,
        ]);
        return shapeAssignment(full.rows[0]);
    });
}
