import { validationResult } from 'express-validator';
import { ApiError } from '#/utils/ApiError.mjs';

export function validate(req, res, next) {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const message = errors.array().map(e => `${e.path}: ${e.msg}`).join(', ');
    return next(new ApiError(422, message));
  }
  next();
}