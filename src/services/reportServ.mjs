import { query } from "#/services/db.mjs";
import * as userServ from '#/services/userServ.mjs';

export async function logReportWithCoordinates({ latitude, longitude, user_id }){
    try{
        const text = "INSERT INTO reports(latitude, longitude, reported_by) VALUES($1, $2, $3) RETURNING *;";
        const values = [latitude, longitude, user_id];
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
                   r.created_at,
                   r.reported_by,
                   u.username AS reporter_username,
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
            reported_by, reporter_username, first_name, last_name,
            age, gender, person_city, person_barangay, street, address, disabilities, pets,
            ...rest
        } = row;
        return {
            ...rest,
            images: images.rows,
            reporter: reported_by == null ? null : {
                user_id: reported_by,
                username: reporter_username,
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
