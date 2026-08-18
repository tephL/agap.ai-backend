import * as userServ from '#/services/userServ.mjs';
import { matchedData } from 'express-validator';
import * as jwt from '#/services/jwtHelper.mjs';
import { comparePassword } from '#/services/hasher.mjs';

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

export async function login(req, res){
    try{
        const { phone_number, password }  = matchedData(req);
        const user = await userServ.getUserWithPhone(phone_number);
        const isPassCorrect = comparePassword(password, user.hashed_password);
        if(!isPassCorrect) return res.sendStatus(401);

        const token = jwt.generateToken({
            username: user.username,
            user_id: user.user_id
        });

        res.cookie("token", token, {
            httpOnly: true, 
            secure: process.env.DEV != true, 
            sameSite: "lax", 
            maxAge: 24 * 60 * 60 * 1000
        });

        return res.status(200).json({
            message: "Login successful",
            token
        });

    } catch(err){
        console.log(err);
        return res.sendStatus(500);
    }
}
