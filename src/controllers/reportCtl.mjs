import { uploadImageToCloudinary } from "#/services/cloudinaryUploader.mjs";
import * as imageServ from '#/services/imageServices.mjs';
import * as helperMid from '#/middlewares/helper-mid.mjs';

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

        const uploadResults = await Promise.all(
            req.files.map(file => uploadImageToCloudinary(file.buffer))
        );

        const urls = uploadResults.map(result => result.url);
        await imageServ.logImageUploads({ urls, user_id });

        return res.sendStatus(200);
    } catch(e){
        console.log(e);
        return res.status(500).json({ message: 'Upload failed' });
    }
}
