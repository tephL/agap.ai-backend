import * as userServ from '#/services/userServ.mjs';
import { matchedData } from 'express-validator';
import * as jwt from '#/services/jwtHelper.mjs';
import { comparePassword } from '#/services/hasher.mjs';
import { whoIsUser } from '#/middlewares/helper-mid.mjs';

export async function createUser(req, res){
    try{
        const { password, phone_number } = matchedData(req);
        const trimmed_phone_number = String(phone_number).replace(/^0/, '');;
        const user = await userServ.createUser({ password, phone_number: trimmed_phone_number });
        return res.sendStatus(201);
    } catch(err){
        console.log(err);
        if(err.code == 23505){
            return res.status(400).json({
                message: "Phone number already registered"
            });
        }
        return res.sendStatus(500);
    }
}

export async function getProfile(req, res){
    try{
        const { user_id } = whoIsUser(req);
        const user = await userServ.getUserPersonalDetails(user_id);
        return res.status(200).json(user);
    } catch(err){
        console.log(err);
        return res.sendStatus(500);
    }
}

export async function login(req, res){
    try{
        const { phone_number, password }  = matchedData(req);
        const trimmed_phone_number = String(phone_number).replace(/^0/, '');;
        const user = await userServ.getUserWithPhone(trimmed_phone_number);
        if(!user) return res.sendStatus(401);
        const isPassCorrect = comparePassword(password, user.hashed_password);
        if(!isPassCorrect) return res.sendStatus(401);

        const token = jwt.generateToken({
            username: user.username,
            user_id: user.user_id,
            role_id: user.role_id
        });

        res.cookie("token", token, {
            httpOnly: true, 
            secure: process.env.DEV != true, 
            sameSite: "lax", 
            maxAge: 24 * 60 * 60 * 1000
        });

        return res.status(200).json({
            message: "Login successful",
            token,
            role_id: user.role_id
        });

    } catch(err){
        console.log(err);
        return res.sendStatus(500);
    }
}

export function logout(req, res){
    res.clearCookie('token');
    return res.sendStatus(204);
}
