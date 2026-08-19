import { Pool } from "pg";
import { DEV } from '#/config/env.mjs';

export const pool = new Pool({
    user: process.env.DB_USERNAME, 
    host: process.env.DB_HOST, 
    password: process.env.DB_PASSWORD, 
    database: process.env.DB_NAME, 
    port: process.env.DB_PORT
});

export function query(text, values){
    return pool.query(text, values);
}

export async function withTransaction(fn) {
    const client = await pool.connect();
    try {
        await client.query('BEGIN');
        const result = await fn(client);
        await client.query('COMMIT');
        return result;
    } catch (err) {
        await client.query('ROLLBACK');
        throw err;
    } finally {
        client.release();
    }
}
