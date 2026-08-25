import { body, query } from 'express-validator';

export const validateChatMessage = [
    body('message')
        .trim()
        .notEmpty().withMessage('message is required')
        .isLength({ max: 2000 }).withMessage('message must be 2000 characters or fewer'),
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
