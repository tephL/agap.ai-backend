import { Router } from "express";
import * as userMid from '#/middlewares/users-validators.mjs';
import * as userCtl from '#/controllers/users-validators.mjs';
import * as helperMid from '#/middlewares/helper-mid.mjs';

const router = Router();
router.use(helperMid.isUserLoggedIn);

router.post('/location', 
    userMid.locationValidator,
    userCtl.getUserLocation
);

export default router;
