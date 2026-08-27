import { Router } from 'express';
import * as dispatcherController from '#/controllers/dispatcher.controller.mjs';
import { validate } from '#/middlewares/validate.mjs';
import { isUserLoggedIn, isDispatcher } from '#/middlewares/helper-mid.mjs';
import {
  createTeamValidator,
  teamIdParamValidator,
  clusterIdParamValidator,
  assignmentIdParamValidator,
  clusterStatusBodyValidator,
  assignmentStatusBodyValidator,
  createAssignmentValidator,
  clusterListQueryValidator,
  updateTeamValidator,
  relocateTeamValidator,
} from '#/validators/dispatcher.validators.mjs';

const router = Router();

// Everything under /api/dispatcher is for authenticated dispatchers only.
router.use(isUserLoggedIn, isDispatcher);

router.get('/teams', dispatcherController.getTeams);
router.post('/teams', createTeamValidator, validate, dispatcherController.createTeam);
router.get(
  '/teams/:teamId/assignment',
  teamIdParamValidator,
  validate,
  dispatcherController.getTeamAssignment
);
router.patch(
  '/teams/:teamId',
  teamIdParamValidator,
  updateTeamValidator,
  validate,
  dispatcherController.updateTeam
);
router.patch(
  '/teams/:teamId/relocate',
  teamIdParamValidator,
  relocateTeamValidator,
  validate,
  dispatcherController.relocateTeam
);

router.get(
  '/clusters',
  clusterListQueryValidator,
  validate,
  dispatcherController.getClusters
);
router.patch(
  '/clusters/:id/status',
  clusterIdParamValidator,
  clusterStatusBodyValidator,
  validate,
  dispatcherController.updateClusterStatus
);

router.post(
  '/assignments',
  createAssignmentValidator,
  validate,
  dispatcherController.createAssignment
);
router.patch(
  '/assignments/:id/status',
  assignmentIdParamValidator,
  assignmentStatusBodyValidator,
  validate,
  dispatcherController.updateAssignmentStatus
);

export default router;
