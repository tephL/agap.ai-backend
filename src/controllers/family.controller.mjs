import * as familyService from '#/services/family.service.mjs';

export async function createFamily(req, res) {
  try {
    const { name } = req.body;
    const family = await familyService.createFamily(name);
    res.status(201).json(family);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
}

export async function getFamilies(req, res) {
  try {
    const limit = Math.min(Number(req.query.limit) || 50, 100);
    const offset = Number(req.query.offset) || 0;
    const families = await familyService.getFamilies({ limit, offset });
    res.status(200).json(families);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
}

export async function getFamilyById(req, res) {
  try {
    const family = await familyService.getFamilyById(req.params.id);
    if (!family) return res.status(404).json({ error: 'Family not found' });
    res.status(200).json(family);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
}

export async function getFamilyMembers(req, res) {
  try {
    const family = await familyService.getFamilyById(req.params.id);
    if (!family) return res.status(404).json({ error: 'Family not found' });
    const members = await familyService.getFamilyMembers(req.params.id);
    res.status(200).json({ ...family, members });
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
}

export async function updateFamily(req, res) {
  try {
    const { name } = req.body;
    const family = await familyService.updateFamily(req.params.id, name);
    if (!family) return res.status(404).json({ error: 'Family not found' });
    res.status(200).json(family);
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
}

export async function deleteFamily(req, res) {
  try {
    const deleted = await familyService.deleteFamily(req.params.id);
    if (!deleted) return res.status(404).json({ error: 'Family not found' });
    res.status(204).send();
  } catch (err) {
    console.error(err);
    res.sendStatus(500);
  }
}
