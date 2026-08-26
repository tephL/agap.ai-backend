import { Router } from "express";
import { isUserLoggedIn, isDispatcher } from "#/middlewares/helper-mid.mjs";
import * as typhoonCtl from "#/controllers/typhoonCtl.mjs";

const router = Router();

// Active typhoon — any logged-in user (citizens need this for the alert banner)
router.get("/active", isUserLoggedIn, typhoonCtl.getActiveTyphoon);

// Admin-only endpoints
router.get("/", isUserLoggedIn, isDispatcher, typhoonCtl.getAllTyphoons);
router.post("/", isUserLoggedIn, isDispatcher, typhoonCtl.createTyphoon);
router.patch("/:id", isUserLoggedIn, isDispatcher, typhoonCtl.updateTyphoon);
router.delete("/:id", isUserLoggedIn, isDispatcher, typhoonCtl.deleteTyphoon);

export default router;
