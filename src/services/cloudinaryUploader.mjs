import cloudinary from '#/config/cloudinary.mjs';

export function uploadImageToCloudinary(buffer, folder = 'uploads'){
    return new Promise((resolve, reject) => {
        const stream = cloudinary.uploader.upload_stream(
            {
                folder,
                transformation: [{ width: 1000, crop: 'limit' }]
            },
            (err, res) => {
                if(err) return reject(err);
                resolve(res);
            }
        );
        stream.end(buffer);
    });
}
