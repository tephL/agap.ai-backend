import { query } from "#/services/db.mjs";

export async function logImageUploads({ urls, user_id }){
    try {
        const values = [];
        const placeholders = urls.map((url, i) => {
            values.push(url);
            return `($${i + 1}, $${urls.length + 1})`;
        });
        values.push(user_id);

        const text = `INSERT INTO images(public_url, submitted_by) VALUES ${placeholders.join(', ')};`;
        return await query(text, values);
    } catch(e){
        throw e;
    }
}
