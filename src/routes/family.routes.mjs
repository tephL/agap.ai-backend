import { Router } from 'express';
import * as familyController from '#/controllers/family.controller.mjs';
import { validate } from '#/middlewares/validate.mjs';
import { isUserLoggedIn } from '#/middlewares/helper-mid.mjs';
import {
  createFamilyValidator,
  updateFamilyValidator,
  familyIdParamValidator,
  inviteMemberValidator,
  familyMemberIdParamValidator,
} from '#/validators/family.validators.mjs';

const router = Router();

router.post('/', isUserLoggedIn, createFamilyValidator, validate, familyController.createFamily);
router.get('/location', isUserLoggedIn, familyController.getFamilyLocation);
router.get('/members/report-status', isUserLoggedIn, familyController.getFamilyMembersReportStatus);
router.get('/', isUserLoggedIn, familyController.getFamilies);
router.get('/mine', isUserLoggedIn, familyController.getMyFamily);
router.get('/:id', isUserLoggedIn, familyIdParamValidator, validate, familyController.getFamilyById);
router.get('/:id/members', isUserLoggedIn, familyIdParamValidator, validate, familyController.getFamilyMembers);
router.put('/:id', isUserLoggedIn, updateFamilyValidator, validate, familyController.updateFamily);
router.delete('/:id', isUserLoggedIn, familyIdParamValidator, validate, familyController.deleteFamily);
router.post('/:id/invite', isUserLoggedIn, inviteMemberValidator, validate, familyController.inviteMember);
router.delete('/:id/members/:memberId', isUserLoggedIn, familyMemberIdParamValidator, validate, familyController.removeMember);
router.post('/:id/leave', isUserLoggedIn, familyIdParamValidator, validate, familyController.leaveFamily);
export default router;
