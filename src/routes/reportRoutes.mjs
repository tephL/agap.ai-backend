import { Router } from "express";
import * as helperMid from '#/middlewares/helper-mid.mjs';
import * as reportCtl from '#/controllers/reportCtl.mjs';
import * as reportMid from '#/middlewares/reports-mid.mjs';
import * as usersMid from '#/middlewares/users-validators.mjs';

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

export default router
