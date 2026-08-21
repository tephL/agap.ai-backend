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
