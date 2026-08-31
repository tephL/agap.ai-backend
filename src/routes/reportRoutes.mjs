import { Router } from "express";
import { body, param } from "express-validator";
import * as helperMid from '#/middlewares/helper-mid.mjs';
import * as reportCtl from '#/controllers/reportCtl.mjs';
import * as reportMid from '#/middlewares/reports-mid.mjs';
import * as usersMid from '#/middlewares/users-validators.mjs';

const REPORT_STATUSES = ['open', 'saved', 'resolved'];

const reportIdParamValidator = [
  param('reportId')
    .isInt({ min: 1 }).withMessage('reportId must be a positive integer')
    .toInt(),
];

const reportStatusBodyValidator = [
  body('status')
    .trim()
    .notEmpty().withMessage('status is required')
    .isIn(REPORT_STATUSES).withMessage(`status must be one of: ${REPORT_STATUSES.join(', ')}`),
];

const router = Router();
router.use(helperMid.isUserLoggedIn);

router.post('/upload', 
    reportMid.handleImageUploads, 
    reportCtl.uploadReportedImage
);

router.post('/description',
    reportMid.validateDescription, 
    helperMid.catchValidationError,
    reportCtl.attachDescriptionToReport
);

router.post('/location',
    usersMid.locationValidator,
    helperMid.catchValidationError,
    reportCtl.reportWithLocation
);

router.get('/:reportId',
    reportCtl.getReportById
);

router.patch('/:reportId/status',
    reportIdParamValidator,
    reportStatusBodyValidator,
    helperMid.catchValidationError,
    reportCtl.updateReportStatus
);

router.delete('/:reportId',
    reportIdParamValidator,
    helperMid.catchValidationError,
    reportCtl.deleteOwnReport
);

export default router
