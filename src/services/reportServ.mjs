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
            SELECT EXISTS (
                SELECT 1
                FROM reports
                WHERE reported_by = $1
                  AND created_at >= NOW() - INTERVAL '5 minutes'
            ) AS has_recent_report;
        `;
        const values = [user_id];
        const check = await query(text, values);
        return check.rows[0].has_recent_report;
    } catch(e){
        throw e;
    }
}
