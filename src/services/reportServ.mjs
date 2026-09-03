import { query } from "#/services/db.mjs";
import * as userServ from '#/services/userServ.mjs';

export class ReportDispatchedError extends Error {
  constructor(message) {
    super(message || 'A team has already been dispatched to your report cluster and it can no longer be cancelled.');
    this.name = 'ReportDispatchedError';
  }
}

export async function logReportWithCoordinates({ latitude, longitude, user_id, hazard_level_25yr }){
    try{
        const text = "INSERT INTO reports(latitude, longitude, reported_by, hazard_level_25yr) VALUES($1, $2, $3, $4) RETURNING *;";
        const values = [latitude, longitude, user_id, hazard_level_25yr ?? null];
        const report = await query(text, values);
        const logCurrLoc = await userServ.saveUserLocation({ latitude, longitude, user_id });
        return report.rows[0];
    } catch(e){
        throw e;
    }
}

export async function getUserRecentReport({ user_id }){
    try{
        const text = 'select report_id from reports WHERE reported_by = $1 ORDER BY created_at DESC LIMIT 1;';
        const values = [user_id];
        const report_id = await query(text, values);
        return report_id.rows;
    } catch(e){
        throw e;
    }
}

export async function attachDescriptionToReport({ report_id, description }){
    try{
        const text = `UPDATE reports SET description = $2 WHERE report_id = $1;`;
        const values = [report_id, description];
        const q = await query(text, values);
        return q;
    } catch(e){
        throw e;
    }
}

const REPORT_STATUSES = ['open', 'saved', 'resolved'];

export async function updateReportStatus({ report_id, status }){
    if(!REPORT_STATUSES.includes(status)){
        throw new Error(`Invalid status: must be one of ${REPORT_STATUSES.join(', ')}`);
    }
    try{
        const text = `UPDATE reports SET status = $2 WHERE report_id = $1 RETURNING report_id, status;`;
        const values = [report_id, status];
        const result = await query(text, values);
        return result.rows[0] || null;
    } catch(e){
        throw e;
    }
}

/**
 * Deletes a report owned by the given citizen. Blocks deletion when the
 * report's cluster already has a dispatched team assignment (a team that is
 * already en route can't be pulled back by the citizen).
 *
 * Returns true if a report was deleted for this owner, false if it didn't
 * exist (or wasn't owned by them).
 */
export async function deleteReport({ report_id, user_id }){
    try{
        // Block if a team is already en route to this report's cluster.
        const dispatchedCheck = `
            SELECT 1
            FROM report_clusters rc
            JOIN assignment a ON a.cluster_id = rc.cluster_id
            WHERE rc.report_id = $1
              AND a.status = 'dispatched'
            LIMIT 1;
        `;
        const dispatched = await query(dispatchedCheck, [report_id]);
        if (dispatched.rows.length > 0) {
            throw new ReportDispatchedError();
        }

        // report_images -> images has no ON DELETE CASCADE, so clear links.
        await query(`DELETE FROM report_images WHERE report_id = $1;`, [report_id]);

        const text = `DELETE FROM reports WHERE report_id = $1 AND reported_by = $2 RETURNING report_id;`;
        const result = await query(text, [report_id, user_id]);

        return result.rows.length > 0;
    } catch(e){
        throw e;
    }
}

export async function getReportDetailsById({ report_id }){
    try{
        const text = `
            SELECT r.report_id,
                   r.latitude,
                   r.longitude,
                   r.description,
                   r.ai_summary,
                   r.status,
                   r.people_affected,
                   r.hazard_level_25yr,
                   r.created_at,
                   r.reported_by,
                   u.username AS reporter_username,
                   u.phone_number AS reporter_phone,
                   p.first_name,
                   p.last_name,
                   p.age,
                   p.gender,
                   p.city AS person_city,
                   p.barangay AS person_barangay,
                   p.street,
                   p.address,
                   p.disabilities,
                   p.pets,
                   rc.cluster_id
            FROM reports r
                LEFT JOIN users u
                    ON u.user_id = r.reported_by
                LEFT JOIN people p
                    ON p.person_id = u.person_id
                LEFT JOIN report_clusters rc
                    ON rc.report_id = r.report_id
            WHERE r.report_id = $1;
        `;
        const values = [report_id];
        const report = await query(text, values);
        if(report.rows.length === 0) return null;

        const imagesText = `
            SELECT i.image_id, i.public_url, i.created_at
            FROM report_images ri
                JOIN images i
                    ON i.image_id = ri.image_id
            WHERE ri.report_id = $1
            ORDER BY i.created_at ASC;
        `;
        const images = await query(imagesText, values);

        const row = report.rows[0];
        const {
            reported_by, reporter_username, reporter_phone, first_name, last_name,
            age, gender, person_city, person_barangay, street, address, disabilities, pets,
            ...rest
        } = row;
        return {
            ...rest,
            images: images.rows,
            reporter: reported_by == null ? null : {
                user_id: reported_by,
                username: reporter_username,
                phone_number: reporter_phone,
                name: [first_name, last_name].filter(Boolean).join(' '),
                age,
                gender,
                city: person_city,
                barangay: person_barangay,
                street,
                address,
                disabilities,
                pets,
            },
        };
    } catch(e){
        throw e;
    }
}
