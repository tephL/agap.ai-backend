import { ApiError } from '#/utils/ApiError.mjs';

export function errorHandler(err, req, res, next) {
  if (err instanceof ApiError) {
    return res.status(err.statusCode).json({ error: err.message });
  }

  // Postgres unique_violation, in case a unique constraint gets added later
  if (err.code === '23505') {
    return res.status(409).json({ error: 'Resource already exists' });
  }

  console.error(err);
  return res.status(500).json({ error: 'Internal server error' });
}

export function notFoundHandler(req, res) {
  res.status(404).json({ error: 'Route not found' });
}