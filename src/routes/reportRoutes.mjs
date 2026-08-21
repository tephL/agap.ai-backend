import { Router } from "express";
import * as helperMid from '#/middlewares/helper-mid.mjs';
import * as reportCtl from '#/controllers/reportCtl.mjs';
import * as reportMid from '#/middlewares/reports-mid.mjs';

const router = Router();
router.use(helperMid.isUserLoggedIn);

router.post('/upload', 
    reportMid.handleImageUploads, 
    reportCtl.uploadReportedImage
);

export default router
