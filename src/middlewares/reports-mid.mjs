import upload from "#/config/multer.mjs";
import { body } from "express-validator";
import multer from "multer";

export function handleImageUploads(req, res, next){
    upload.array('images', 3)(req, res, (err) => {
        if (err instanceof multer.MulterError) {
            if (err.code === 'LIMIT_UNEXPECTED_FILE') {
                return res.status(400).json({ message: 'You can upload at most 3 images' });
            }
            return res.status(400).json({ message: err.message, code: err.code });
        } else if (err) {
            return res.status(400).json({ message: err.message });
        }
        next();
    });
}

export const validateDescription = [
    body('description')
        .notEmpty()
        .withMessage("Description must be provided")
        .isString()
        .withMessage("Description must be a string")
        .trim()
];
