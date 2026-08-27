import { Router } from "express";
import { isUserLoggedIn } from "#/middlewares/helper-mid.mjs";
import { query } from "#/services/db.mjs";
import * as userServ from "#/services/userServ.mjs";
import { whoIsUser } from "#/middlewares/helper-mid.mjs";

const router = Router();
router.use(isUserLoggedIn);

router.get("/", async (req, res) => {
  try {
    const session = whoIsUser(req);
    if (!session?.user_id) {
      return res.status(401).json({ error: "Not authenticated" });
    }

    const cityId = await userServ.getCityIdForUser(session.user_id);
    if (!cityId) {
      return res.json({ teams: [] });
    }

    const text = `
      SELECT t.team_id, t.name,
             t.latitude AS lat, t.longitude AS lng
      FROM teams t
      WHERE t.city_id = $1
        AND t.is_public = TRUE
        AND t.archived_at IS NULL
        AND t.latitude IS NOT NULL
        AND t.longitude IS NOT NULL;`;

    const result = await query(text, [cityId]);
    const teams = result.rows.map((row) => ({
      team_id: row.team_id,
      name: row.name,
      lat: Number(row.lat),
      lng: Number(row.lng),
    }));

    return res.json({ teams });
  } catch (err) {
    console.error("getPublicTeams error:", err);
    return res.status(500).json({ error: "Failed to load public teams" });
  }
});

export default router;
