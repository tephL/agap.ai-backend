import { Router } from 'express';
import * as invitationController from '#/controllers/invitation.controller.mjs';
import { validate } from '#/middlewares/validate.mjs';
import { isUserLoggedIn } from '#/middlewares/helper-mid.mjs';
import { invitationIdParamValidator } from '#/validators/invitation.validators.mjs';

const router = Router();

router.get('/', isUserLoggedIn, invitationController.getMyInvitations);
router.patch('/:id/accept', isUserLoggedIn, invitationIdParamValidator, validate, invitationController.acceptInvitation);
router.patch('/:id/reject', isUserLoggedIn, invitationIdParamValidator, validate, invitationController.rejectInvitation);

export default router;