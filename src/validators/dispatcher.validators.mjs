import { body, param, query } from 'express-validator';

const TEAM_STATUSES = ['available', 'busy', 'offline'];
const CLUSTER_STATUSES = ['open', 'saved', 'resolved'];
const ASSIGNMENT_STATUSES = ['pending', 'dispatched', 'resolved'];

export const createTeamValidator = [
  body('name')
    .trim()
    .notEmpty().withMessage('name is required')
    .isLength({ max: 150 }).withMessage('name must be 150 characters or fewer'),
  body('contact_number')
    .optional({ values: 'falsy' })
    .trim()
    .isLength({ max: 50 }).withMessage('contact_number must be 50 characters or fewer'),
  body('latitude')
    .optional({ values: 'falsy' })
    .isFloat({ min: -90, max: 90 }).withMessage('latitude must be between -90 and 90')
    .toFloat(),
  body('longitude')
    .optional({ values: 'falsy' })
    .isFloat({ min: -180, max: 180 }).withMessage('longitude must be between -180 and 180')
    .toFloat(),
];

export const teamIdParamValidator = [
  param('teamId')
    .isInt({ min: 1 }).withMessage('teamId must be a positive integer')
    .toInt(),
];

export const clusterIdParamValidator = [
  param('id')
    .isInt({ min: 1 }).withMessage('id must be a positive integer')
    .toInt(),
];

export const clusterStatusBodyValidator = [
  body('status')
    .trim()
    .notEmpty().withMessage('status is required')
    .isIn(CLUSTER_STATUSES).withMessage(`status must be one of: ${CLUSTER_STATUSES.join(', ')}`),
];

export const assignmentStatusBodyValidator = [
  body('status')
    .trim()
    .notEmpty().withMessage('status is required')
    .isIn(ASSIGNMENT_STATUSES).withMessage(`status must be one of: ${ASSIGNMENT_STATUSES.join(', ')}`),
];

export const createAssignmentValidator = [
  body('team_id')
    .isInt({ min: 1 }).withMessage('team_id must be a positive integer')
    .toInt(),
  body('cluster_id')
    .isInt({ min: 1 }).withMessage('cluster_id must be a positive integer')
    .toInt(),
];

export const clusterListQueryValidator = [
  query('status')
    .optional()
    .trim()
    .isIn(CLUSTER_STATUSES).withMessage(`status must be one of: ${CLUSTER_STATUSES.join(', ')}`),
];
