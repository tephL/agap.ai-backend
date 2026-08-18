import { ApiError } from '#/utils/ApiError.mjs';
import * as familyService from '#/services/family.service.mjs';

export async function createFamily(req, res, next) {
  try {
    const { name } = req.body;
    const family = await familyService.createFamily(name);
    res.status(201).json(family);
  } catch (err) {
    next(err);
  }
}

export async function getFamilies(req, res, next) {
  try {
    const limit = Math.min(Number(req.query.limit) || 50, 100);
    const offset = Number(req.query.offset) || 0;
    const families = await familyService.getFamilies({ limit, offset });
    res.status(200).json(families);
  } catch (err) {
    next(err);
  }
}

export async function getFamilyById(req, res, next) {
  try {
    const family = await familyService.getFamilyById(req.params.id);
    if (!family) throw new ApiError(404, 'Family not found');
    res.status(200).json(family);
  } catch (err) {
    next(err);
  }
}

export async function getFamilyMembers(req, res, next) {
  try {
    const family = await familyService.getFamilyById(req.params.id);
    if (!family) throw new ApiError(404, 'Family not found');
    const members = await familyService.getFamilyMembers(req.params.id);
    res.status(200).json({ ...family, members });
  } catch (err) {
    next(err);
  }
}

export async function updateFamily(req, res, next) {
  try {
    const { name } = req.body;
    const family = await familyService.updateFamily(req.params.id, name);
    if (!family) throw new ApiError(404, 'Family not found');
    res.status(200).json(family);
  } catch (err) {
    next(err);
  }
}

export async function deleteFamily(req, res, next) {
  try {
    const deleted = await familyService.deleteFamily(req.params.id);
    if (!deleted) throw new ApiError(404, 'Family not found');
    res.status(204).send();
  } catch (err) {
    next(err);
  }
}