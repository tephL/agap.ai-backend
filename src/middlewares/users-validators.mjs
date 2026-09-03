import { body } from "express-validator";

export const locationValidator = [
  body("latitude")
    .exists({ checkFalsy: false }).withMessage("Latitude is required")
    .bail()
    .isFloat({ min: -90, max: 90 }).withMessage("Latitude must be between -90 and 90")
    .toFloat(),
  body("longitude")
    .exists({ checkFalsy: false }).withMessage("Longitude is required")
    .bail()
    .isFloat({ min: -180, max: 180 }).withMessage("Longitude must be between -180 and 180")
    .toFloat(),
  body("hazard_level_25yr")
    .optional({ values: "null" })
    .bail()
    .isInt({ min: 1, max: 3 }).withMessage("hazard_level_25yr must be 1, 2, or 3")
    .toInt(),
];
