import { Router } from "express";
import * as helperMid from '#/middlewares/helper-mid.mjs';
import * as clusterCtl from '#/controllers/clustersCtl.mjs';
import { clusterIdParamValidator } from '#/validators/dispatcher.validators.mjs';
import { validate } from '#/middlewares/validate.mjs';

const router = Router();
router.use(helperMid.isUserLoggedIn);
router.use(helperMid.isDispatcher);

router.get('/', 
  clusterCtl.getClustersOfMyCity
);

router.get('/:id/reports',
  clusterIdParamValidator,
  validate,
  clusterCtl.getReportsInCluster
);

export default router;
