import { body, query } from 'express-validator';

export const validateChatMessage = [
    body('message')
        .trim()
        .notEmpty().withMessage('message is required')
        .isLength({ max: 2000 }).withMessage('message must be 2000 characters or fewer'),
    body('hazardContext')
        .optional()
        .isObject().withMessage('hazardContext must be an object'),
    body('hazardContext.hazardLayerId')
        .optional()
        .isString().withMessage('hazardContext.hazardLayerId must be a string')
        .trim()
        .notEmpty().withMessage('hazardContext.hazardLayerId cannot be empty')
        .isIn(['flood_5yr', 'flood_25yr', 'flood_100yr']).withMessage('hazardContext.hazardLayerId must be a known flood layer'),
    body('hazardContext.hazardVar')
        .optional()
        .isInt({ min: 1, max: 3 }).withMessage('hazardContext.hazardVar must be 1, 2, or 3')
        .toInt(),
];

export const validatePagination = [
    query('limit')
        .optional()
        .isInt({ min: 1, max: 50 }).withMessage('limit must be between 1 and 50')
        .toInt(),
    query('offset')
        .optional()
        .isInt({ min: 0 }).withMessage('offset must be 0 or greater')
        .toInt(),
];
