import { body } from "express-validator";

export const validateNewUser = [
    body('username')
        .notEmpty()
        .withMessage("Username is required"), 
    body('phone_number')
        .notEmpty()
        .withMessage("Phone number is required"), 
    body('password')
        .notEmpty()
        .withMessage("Password is required")
        .isLength({min: 8})
        .withMessage("Password must be atleast 8 characters"), 
];
