import { matchedData } from "express-validator";
import * as helperMid from '#/middlewares/helper-mid.mjs';

export async function getUserLocation(req, res){
    try{
        const { longitude, latitude } = matchedData(req);
        const { user_id } = helperMid.whoIsUser(req);
        console.log(user_id);
        console.log(longitude);
        console.log(latitude);
        return res.sendStatus(200);
    } catch(e){
        console.log(e);
        return res.sendStatus(500);
    }
}
