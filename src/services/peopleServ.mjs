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

export async function isPersonOwnedByUser({ person_id, user_id }){
    try{
        const text = "SELECT * FROM users WHERE person_id = $1 AND user_id = $2";
        const values = [person_id, user_id];
        const found = await query(text, values);
        return found.rows.length == 1;
    } catch(err){
        throw err;
    }
}

export async function editPersonDetails({ person_id, ...updates }){
    try{
        const keys = Object.keys(updates);
        let i = 2;
        const placeholders = Object.entries(updates).map(([key]) => `${key} = $${i++}`);
        const text = `UPDATE people SET ${placeholders.join(', ')} WHERE person_id = $1`;
        const values = [person_id, ...Object.values(updates)];
        const person = await query(text, values);
        return;
    } catch(err){
        throw err;
    }
}
