import { Router } from "express";
import * as helperMid from '#/middlewares/helper-mid.mjs';
import * as clusterCtl from '#/controllers/clustersCtl.mjs';

const router = Router();
router.use(helperMid.isUserLoggedIn);
router.use(helperMid.isDispatcher);

router.get('/', 
  clusterCtl.getClustersOfMyCity
);

export default router;
