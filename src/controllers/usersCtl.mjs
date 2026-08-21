import { matchedData } from "express-validator";
import * as helperMid from '#/middlewares/helper-mid.mjs';
import * as userServ from '#/services/userServ.mjs';

export async function getUserLocation(req, res){
    try{
        const { longitude, latitude } = matchedData(req);
        const { user_id } = helperMid.whoIsUser(req);
        const setLoc = await userServ.saveUserLocation({ latitude, longitude, user_id });
        return res.sendStatus(200);
    } catch(e){
        console.log(e);
        return res.sendStatus(500);
    }
}
