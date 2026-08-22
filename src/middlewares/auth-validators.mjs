import { body } from "express-validator";

export const validateNewUser = [
    body('phone_number')
        .notEmpty()
        .withMessage("Phone number is required"), 
    body('password')
        .notEmpty()
        .withMessage("Password is required")
        .isLength({min: 8})
        .withMessage("Password must be atleast 8 characters"), 
];

export const validateLogin = [
    body('phone_number')
        .notEmpty()
        .withMessage("Phone number is required"), 
    body('password')
        .notEmpty()
        .withMessage("Password is required")
        .isLength({min: 8})
        .withMessage("Password must be atleast 8 characters"), 
];
