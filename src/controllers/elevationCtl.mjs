import { getElevation } from "#/services/elevationServ.mjs";

export async function getElevationCtrl(req, res) {
  const { lat, lng } = req.query;
  if (lat == null || lng == null) {
    return res.status(400).json({ elevation: null });
  }

  try {
    const elevation = await getElevation({ latitude: lat, longitude: lng });
    // null is meaningful ("unknown") — the mobile hook treats a 200 with
    // elevation:null exactly like a graceful miss, so keep it quiet.
    return res.json({ elevation: elevation ?? null });
  } catch (err) {
    console.error("Elevation lookup failed:", err);
    return res.json({ elevation: null });
  }
}