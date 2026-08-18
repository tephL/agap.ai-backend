import { Router } from "express";
import * as helperMid from '#/middlewares/helper-mid.mjs';

const router = Router();
router.use(helperMid.isUserLoggedIn);

router.post('/',
    (req, res) => {
        return res.sendStatus(200);
    }
);

export default router
