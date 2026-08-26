import { matchedData } from "express-validator";
import * as helperMid from '#/middlewares/helper-mid.mjs';
import * as userServ from '#/services/userServ.mjs';
import * as geminiServ from '#/services/geminiServ.mjs';

export async function getUserLocation(req, res){
    try{
        const { longitude, latitude } = matchedData(req);
        const { user_id } = helperMid.whoIsUser(req);
        await userServ.saveUserLocation({ latitude, longitude, user_id });

        let baseline = null;
        try {
            const personDetails = await userServ.getUserPersonalDetails(user_id);
            const location = { latitude: Number(latitude), longitude: Number(longitude) };
            baseline = await geminiServ.analyzeBaseline({ location, personDetails });
        } catch (e) {
            console.error(`Baseline analysis failed for user ${user_id}:`, e.message);
        }

        return res.status(200).json({ baseline });
    } catch(e){
        console.log(e);
        return res.sendStatus(500);
    }
}
