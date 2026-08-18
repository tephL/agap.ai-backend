import { body } from "express-validator";

export const validateNewPerson = [
    body('first_name')
        .trim()
        .notEmpty()
        .withMessage('First name must be provided')
        .isLength({ max: 100 })
        .withMessage('First name must not exceed 100 characters'),
    body('middle_name')
        .optional({ checkFalsy: true })
        .trim()
        .isLength({ max: 100 })
        .withMessage('Middle name must not exceed 100 characters'),
    body('last_name')
        .trim()
        .notEmpty()
        .withMessage('Last name must be provided')
        .isLength({ max: 100 })
        .withMessage('Last name must not exceed 100 characters'),
    body('gender')
        .notEmpty()
        .withMessage('Gender must be provided')
        .isIn(['male', 'female', 'other'])
        .withMessage('Gender must be one of: male, female, other'),
    body('disabilities')
        .optional({ checkFalsy: true })
        .isArray()
        .withMessage('Disabilities must be an array')
        .custom((arr) => arr.every((item) => typeof item === 'string'))
        .withMessage('Each disability must be a string'),
    body('age')
        .notEmpty()
        .withMessage('Age must be provided')
        .isInt({ min: 0, max: 150 })
        .withMessage('Age must be a valid number between 0 and 150')
        .toInt(),
    body('city')
        .trim()
        .notEmpty()
        .withMessage('City must be provided')
        .isLength({ max: 100 })
        .withMessage('City must not exceed 100 characters'),
    body('barangay')
        .trim()
        .notEmpty()
        .withMessage('Barangay must be provided')
        .isLength({ max: 100 })
        .withMessage('Barangay must not exceed 100 characters'),
    body('street')
        .optional({ checkFalsy: true })
        .trim()
        .isLength({ max: 150 })
        .withMessage('Street must not exceed 150 characters'),
    body('address')
        .trim()
        .notEmpty()
        .withMessage('Address must be provided')
        .isLength({ max: 255 })
        .withMessage('Address must not exceed 255 characters'),
];
