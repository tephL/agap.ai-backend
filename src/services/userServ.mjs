import { query } from "#/services/db.mjs";
import { hashPassword } from '#/services/hasher.mjs';

export async function createUser({ username, password, phone_number }){
    try{
        const hashed_password = hashPassword(password);
        const text = "INSERT INTO users(username, hashed_password, phone_number, role_id) VALUES ($1, $2, $3, 100);";
        const values = [username, hashed_password, phone_number];
        const user = await query(text, values);
        return user;
    } catch(err){
        throw err;
    }
}
