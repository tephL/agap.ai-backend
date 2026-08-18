import { Router } from 'express';
import * as authCtl from '#/controllers/authCtl.mjs';
import * as authMid from '#/middlewares/auth-validators.mjs';
import * as helperMid from '#/middlewares/helper-mid.mjs';

const router = Router();

router.post('/register',
    authMid.validateNewUser,
    helperMid.catchValidationError, 
    authCtl.createUser
);

export default router;
