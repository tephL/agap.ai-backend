import { query } from "#/services/db.mjs";

export async function logImageUpload({ url, user_id }){
    try{
        const text = "INSERT INTO images(public_url, submitted_by) VALUES($1, $2);";
        const values = [url, user_id];
        const log = await query(text, values);
        return;
    } catch(e){
        throw e;
    }
}
