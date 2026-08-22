import { query } from "#/services/db.mjs";
import * as userServ from '#/services/userServ.mjs';

export async function logReportWithCoordinates({ latitude, longitude, user_id }){
    try{
        const text = "INSERT INTO reports(latitude, longitude, reported_by) VALUES($1, $2, $3);";
        const values = [latitude, longitude, user_id];
        const report = query(text, values);
        const logCurrLoc = await userServ.saveUserLocation({ latitude, longitude, user_id });
        return;
    } catch(e){
        throw e;
    }
}

export async function checkReportInterval({ user_id }){
    try{
        const text = `
            SELECT report_id
            FROM reports
            WHERE reported_by = $1
                AND created_at >= NOW() - INTERVAL '5 minutes'
            ORDER BY created_at DESC
            LIMIT 1;
        `;
        const values = [user_id];
        const check = await query(text, values);
        return check.rows[0];
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
