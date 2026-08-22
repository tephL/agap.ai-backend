import { uploadImageToCloudinary } from "#/services/cloudinaryUploader.mjs";
import * as imageServ from '#/services/imageServices.mjs';
import * as helperMid from '#/middlewares/helper-mid.mjs';
import { matchedData } from "express-validator";
import { whoIsUser } from "#/middlewares/helper-mid.mjs";
import * as reportServ from "#/services/reportServ.mjs";
import { checkReportInterval } from "#/services/reportServ.mjs";

const MIN_FILES = 1;
const MAX_FILES = 3;

export async function uploadReportedImage(req, res){
    if (!req.files || req.files.length < MIN_FILES) {
        return res.status(400).json({ message: `Please upload at least ${MIN_FILES} image` });
    }
    if (req.files.length > MAX_FILES) {
        return res.status(400).json({ message: `You can upload at most ${MAX_FILES} images` });
    }

    try {
        const { user_id } = helperMid.whoIsUser(req);
        const { report_id } = await checkReportInterval({ user_id });
        if(report_id == undefined) return res.status(200).json({ message: "No reports to attach image to have been made in the past 5 minutes" });

        const uploadResults = await Promise.all(
            req.files.map(file => uploadImageToCloudinary(file.buffer))
        );

        const urls = uploadResults.map(result => result.url);
        await imageServ.logImageUploads({ urls, user_id, report_id });

        return res.sendStatus(200);
    } catch(e){
        console.log(e);
        return res.status(500).json({ message: 'Upload failed' });
    }
}

export async function reportWithLocation(req, res){
    try{
        const { latitude, longitude } = matchedData(req);
        const { user_id } = whoIsUser(req);
        const report = await reportServ.logReportWithCoordinates({ latitude, longitude, user_id }); 
        return res.sendStatus(200);
    } catch(e){
        console.log(e);
        return res.sendStatus(500);
    }
}
