import cloudinary from '#/config/cloudinary.mjs';

function getCurrentDateFormatted() {
    const now = new Date();
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const day = String(now.getDate()).padStart(2, '0');
    return `${year}_${month}_${day}`;
}

export function uploadImageToCloudinary(buffer, folder = getCurrentDateFormatted()){
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
