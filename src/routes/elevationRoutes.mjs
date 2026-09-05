import { Router } from "express";
import { getElevationCtrl } from "#/controllers/elevationCtl.mjs";

const router = Router();

// Public utility — the mobile hazard screen calls this without auth.
router.get("/", getElevationCtrl);

export default router;