import { Router } from "express";
import * as helperMid from '#/middlewares/helper-mid.mjs';
import * as peopleMid from '#/middlewares/people-validators.mjs';
import * as peopleCtl from '#/controllers/peopleCtl.mjs';

const router = Router();
router.use(helperMid.isUserLoggedIn);

router.post('/',
    peopleMid.validateNewPerson,
    helperMid.catchValidationError, 
    peopleCtl.createPersonalDetails
);

router.get('/:person_id',
    peopleCtl.getPersonById
);

router.patch('/:person_id', 
    peopleMid.validateUpdatePerson,
    helperMid.catchValidationError, 
    peopleCtl.editPersonById
);

export default router
