import * as typhoonServ from "#/services/typhoonServ.mjs";

export async function getActiveTyphoon(req, res) {
  try {
    const typhoon = await typhoonServ.getActiveTyphoon();
    return res.json({ typhoon });
  } catch (err) {
    console.error("getActiveTyphoon error:", err);
    return res.status(500).json({ error: "Failed to fetch active typhoon" });
  }
}

export async function getAllTyphoons(req, res) {
  try {
    const typhoons = await typhoonServ.getAllTyphoons();
    return res.json({ typhoons });
  } catch (err) {
    console.error("getAllTyphoons error:", err);
    return res.status(500).json({ error: "Failed to fetch typhoons" });
  }
}

export async function createTyphoon(req, res) {
  try {
    const { name, category, status, source } = req.body;
    if (!name?.trim()) {
      return res.status(400).json({ error: "Name is required" });
    }
    const typhoon = await typhoonServ.createTyphoon({ name, category, status, source });
    return res.status(201).json({ typhoon });
  } catch (err) {
    console.error("createTyphoon error:", err);
    return res.status(500).json({ error: "Failed to create typhoon" });
  }
}

export async function updateTyphoon(req, res) {
  try {
    const { id } = req.params;
    const { name, category, status, source } = req.body;
    const typhoon = await typhoonServ.updateTyphoon(Number(id), { name, category, status, source });
    if (!typhoon) {
      return res.status(404).json({ error: "Typhoon not found" });
    }
    return res.json({ typhoon });
  } catch (err) {
    console.error("updateTyphoon error:", err);
    return res.status(500).json({ error: "Failed to update typhoon" });
  }
}

export async function deleteTyphoon(req, res) {
  try {
    const { id } = req.params;
    await typhoonServ.deleteTyphoon(Number(id));
    return res.sendStatus(204);
  } catch (err) {
    console.error("deleteTyphoon error:", err);
    return res.status(500).json({ error: "Failed to delete typhoon" });
  }
}
