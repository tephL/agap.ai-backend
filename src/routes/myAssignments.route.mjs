import { Router } from "express";
import { isUserLoggedIn } from "#/middlewares/helper-mid.mjs";
import { getMyAssignments } from "#/controllers/myAssignments.ctl.mjs";

const router = Router();
router.use(isUserLoggedIn);

router.get("/", getMyAssignments);

export default router;
