import * as userServ from '#/services/userServ.mjs';
import { matchedData } from 'express-validator';

export async function createUser(req, res){
    try{
        const { username, password, phone_number } = matchedData(req);
        const user = await userServ.createUser({ username, password, phone_number });
        return res.sendStatus(201);
    } catch(err){
        console.log(err);
        if(err.code == 23505){
            return res.status(400).json({
                message: "Username already exists"
            });
        }
        return res.sendStatus(500);
    }
}
