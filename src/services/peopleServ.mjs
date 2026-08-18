import { query, pool } from "#/services/db.mjs";

export async function createPersonalDetails({ user_id, ...details }){
    const client = await pool.connect();
    const keys = Object.keys(details);
    let i = 1;
    const placeholders = Object.entries(details).map(() => {
        return `$${i++}`;
    });
    const values = Object.values(details);

    try{
        await client.query('BEGIN');
        const text = `INSERT INTO people(${keys.join(', ')}) VALUES (${placeholders}) RETURNING person_id;`;
        const insertPerson = await client.query(text, values);

        const person_id = insertPerson.rows[0].person_id;
        const assignPerson = await client.query('UPDATE users SET person_id = $1 WHERE user_id = $2', [person_id, user_id]);
        await client.query('COMMIT');
        return true;
    } catch(err){
        await client.query('ROLLBACK');
        throw err;
    }
}

export async function getPersonById(person_id){
    try{
        const person = await query(
            "SELECT * FROM people WHERE person_id = $1",
            [person_id]
        );
        return person.rows[0];
    } catch(err){
        throw err;
    }
}
