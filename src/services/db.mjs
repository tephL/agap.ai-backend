import { Pool } from "pg";
import dotenv from 'dotenv';
dotenv.config();

const DEV = process.env.DEV;

const pool = new Pool({
    user: process.env.DB_USERNAME, 
    host: DEV ? 'localhost' : process.env.DB_HOST, 
    password: process.env.DB_PASSWORD, 
    database: 'agap', 
    port: process.env.DB_PORT
});

export async function query(text, values){
    return await pool.query(text, values);
}
