import { uploadImageToCloudinary } from "#/services/cloudinaryUploader.mjs";
import * as imageServ from '#/services/imageServices.mjs';
import * as helperMid from '#/middlewares/helper-mid.mjs';

export async function uploadReportedImage(req, res){
    if(!req.file) return res.status(400).json({ message: 'No file received' });

    try{
        const result = await uploadImageToCloudinary(req.file.buffer);
        const { user_id } = helperMid.whoIsUser(req);
        const log = await imageServ.logImageUpload({ url: result.url, user_id: user_id});
        return res.sendStatus(200);
    } catch(e){
        console.log(e);
        return res.sendStatus(500);
    }
}
