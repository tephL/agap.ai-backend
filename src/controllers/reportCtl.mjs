import { uploadImageToCloudinary } from "#/services/cloudinaryUploader.mjs";

export async function uploadReportedImage(req, res){
    if(!req.file) return res.status(400).json({ message: 'No file received' });

    try{
        const result = await uploadImageToCloudinary(req.file.buffer);
        console.log(result);
        return res.sendStatus(200);
    } catch(e){
        console.log(e);
        return res.sendStatus(500);
    }
}
