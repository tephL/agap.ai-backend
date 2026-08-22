import { pool } from "#/services/db.mjs";

export async function logImageUploads({ urls, user_id, report_id }) {
    const client = await pool.connect(); 
    try {
        await client.query('BEGIN');

        const values = [];
        const placeholders = urls.map((url, i) => {
            values.push(url);
            return `($${i + 1}, $${urls.length + 1})`;
        });
        values.push(user_id);

        const imagesText = `
            INSERT INTO images(public_url, submitted_by)
            VALUES ${placeholders.join(', ')}
            RETURNING image_id;
        `;

        const { rows } = await client.query(imagesText, values);

        const linkValues = [];
        const linkPlaceholders = rows.map(({ image_id }, i) => {
            linkValues.push(report_id, image_id);
            return `($${linkValues.length - 1}, $${linkValues.length})`;
        });
        const linkText = `
            INSERT INTO report_images(report_id, image_id)
            VALUES ${linkPlaceholders.join(', ')}
            RETURNING *;
        `;
        
        const linking_images_report = await client.query(linkText, linkValues);
        
        await client.query('COMMIT');
        return linking_images_report.rows;
    } catch (e) {
        await client.query('ROLLBACK');
        throw e;
    } finally {
        client.release();
    }
}
