import { body, param } from 'express-validator';

export const familyIdParamValidator = [
  param('id')
    .isInt({ min: 1 }).withMessage('id must be a positive integer')
    .toInt(),
];

export const createFamilyValidator = [
  body('name')
    .trim()
    .notEmpty().withMessage('name is required')
    .isLength({ max: 150 }).withMessage('name must be 150 characters or fewer'),
];

export const updateFamilyValidator = [
  ...familyIdParamValidator,
  body('name')
    .trim()
    .notEmpty().withMessage('name is required')
    .isLength({ max: 150 }).withMessage('name must be 150 characters or fewer'),
];