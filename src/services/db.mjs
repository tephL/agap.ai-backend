import { Pool } from "pg";
import { DEV } from '#/config/env.mjs';

const isLocalHost = ['localhost', '127.0.0.1'].includes(process.env.DB_HOST);

export const pool = new Pool({
    user: process.env.DB_USERNAME, 
    host: process.env.DB_HOST, 
    password: process.env.DB_PASSWORD, 
    database: process.env.DB_NAME, 
    port: process.env.DB_PORT,
    idleTimeoutMillis: 20000,
    connectionTimeoutMillis: 5000,       
    statement_timeout: 10000,             
    idle_in_transaction_session_timeout: 10000,
    ssl: isLocalHost ? false : { rejectUnauthorized: false }
});

export function query(text, values){
    return pool.query(text, values);
}

pool.on('error', (err) => {
  console.error('pg pool idle client error:', err.message);
});

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
