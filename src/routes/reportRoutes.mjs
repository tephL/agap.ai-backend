import { Router } from "express";
import * as helperMid from '#/middlewares/helper-mid.mjs';
import * as reportCtl from '#/controllers/reportCtl.mjs';
import upload from "#/config/multer.mjs";

const router = Router();
router.use(helperMid.isUserLoggedIn);

router.post('/upload', 
    upload.single('image'),
    reportCtl.uploadReportedImage
);

export default router
