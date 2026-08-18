import { Router } from 'express';
import * as familyController from '#/controllers/family.controller.mjs';
import { validate } from '#/middlewares/validate.mjs';
import {
  createFamilyValidator,
  updateFamilyValidator,
  familyIdParamValidator,
} from '#/validators/family.validators.mjs';

const router = Router();

router.post('/', createFamilyValidator, validate, familyController.createFamily);
router.get('/', familyController.getFamilies);
router.get('/:id', familyIdParamValidator, validate, familyController.getFamilyById);
router.get('/:id/members', familyIdParamValidator, validate, familyController.getFamilyMembers);
router.put('/:id', updateFamilyValidator, validate, familyController.updateFamily);
router.delete('/:id', familyIdParamValidator, validate, familyController.deleteFamily);

export default router;