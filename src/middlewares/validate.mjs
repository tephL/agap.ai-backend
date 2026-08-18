import { validationResult } from 'express-validator';

export function validate(req, res, next) {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const message = errors.array().map(e => `${e.path}: ${e.msg}`).join(', ');
    return res.status(422).json({ error: message });
  }
  next();
}