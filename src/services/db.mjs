import { Pool } from "pg";
import dotenv from 'dotenv';
import { DEV } from "#/app.mjs";
dotenv.config();

const pool = new Pool({
    user: process.env.DB_USERNAME, 
    host: DEV ? 'localhost' : process.env.DB_HOST, 
    password: process.env.DB_PASSWORD, 
    database: 'agap', 
    port: 5432
});

export function query(text, values){
    return pool.query(text, values);
}
