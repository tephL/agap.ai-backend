import { query } from "#/services/db.mjs";
import { hashPassword } from '#/services/hasher.mjs';

export async function createUser({ password, phone_number }){
    const hashed_password = hashPassword(password);
    const text = "INSERT INTO users(hashed_password, phone_number, role_id) VALUES ($1, $2, 100);";
    const values = [hashed_password, phone_number];
    const user = await query(text, values);
    return user;
}

export async function saveUserLocation({ latitude, longitude, user_id }){
    try{
        const last_seen = new Date();
        const text = 'UPDATE users SET latitude = $1, longitude = $2, last_seen = $4 WHERE user_id = $3;';
        const values = [latitude, longitude, user_id, last_seen];
        const sql = await query(text, values);
        return;
    } catch(e){
        throw e;
    }
}

export async function getUserWithPhone(phone_number){
    const user = await query(
        "SELECT * from users WHERE phone_number = $1;",
        [phone_number]
    );
    return user.rows[0];
}

export async function getUserPersonalDetails(user_id){
    try{
        const text = "select user_id, u.phone_number, p.first_name, p.middle_name, p.last_name, p.gender, p.disabilities, p.age, p.city, p.barangay, p.street, p.address from users u left join people p on u.person_id = p.person_id where user_id = $1;";
        const values = [user_id];
        const details = await query(text, values);
        const noNull = Object.fromEntries(Object.entries(details.rows[0])
            .filter(([key, value]) => {
                return value !== null
            })
        );
        return noNull;
    } catch(e){
        throw e;
    }
}
