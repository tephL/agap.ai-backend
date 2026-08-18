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

export async function getUserWithPhone(phone_number){
    try{
        const user = await query(
            "SELECT * from users WHERE phone_number = $1;",
            [phone_number]
        );
        return user.rows[0];
    } catch(err){
        console.log(err);
        return res.sendStatus(500);
    }
}
