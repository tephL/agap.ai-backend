import * as familyService from '#/services/family.service.mjs';
import * as invitationService from '#/services/invitation.service.mjs';

export async function createFamily(req, res) {
    try {
        const { name, relation } = req.body;

        const family = await familyService.createFamilyWithCreator(
            name,
            relation,
            req.user.user_id
        );

        res.status(201).json(family);

    } catch (err) {
        console.error(err);

        res.status(500).json({
            error: 'Something went wrong'
        });
    }
}

export async function getFamilies(req, res) {
    try {
        const limit = Math.min(
            Math.max(Number(req.query.limit) || 50, 1),
            100
        );

        const offset = Math.max(
            Number(req.query.offset) || 0,
            0
        );

        const families = await familyService.getFamilies({
            limit,
            offset
        });

        res.status(200).json(families);

    } catch (err) {
        console.error(err);

        res.status(500).json({
            error: 'Something went wrong'
        });
    }
}

export async function getFamilyById(req, res) {
    try {
        const family = await familyService.getFamilyById(
            req.params.id
        );

        if (!family) {
            return res.status(404).json({
                error: 'Family not found'
            });
        }

        res.status(200).json(family);

    } catch (err) {
        console.error(err);

        res.status(500).json({
            error: 'Something went wrong'
        });
    }
}

export async function getFamilyMembers(req, res) {
    try {
        const family = await familyService.getFamilyById(
            req.params.id
        );

        if (!family) {
            return res.status(404).json({
                error: 'Family not found'
            });
        }

        const members = await familyService.getFamilyMembers(
            req.params.id
        );

        res.status(200).json({
            ...family,
            members
        });

    } catch (err) {
        console.error(err);

        res.status(500).json({
            error: 'Something went wrong'
        });
    }
}

export async function updateFamily(req, res) {
    try {
        // FAMILY MANAGER / CREATOR ONLY
        const isCreator = await familyService.isFamilyCreator(
            req.params.id,
            req.user.user_id
        );

        if (!isCreator) {
            return res.status(403).json({
                error: 'Only the family creator can edit this family'
            });
        }

        const { name } = req.body;

        const family = await familyService.updateFamily(
            req.params.id,
            name
        );

        if (!family) {
            return res.status(404).json({
                error: 'Family not found'
            });
        }

        res.status(200).json(family);

    } catch (err) {
        console.error(err);

        res.status(500).json({
            error: 'Something went wrong'
        });
    }
}

export async function deleteFamily(req, res) {
    try {
        // FAMILY MANAGER / CREATOR ONLY
        const isCreator = await familyService.isFamilyCreator(
            req.params.id,
            req.user.user_id
        );

        if (!isCreator) {
            return res.status(403).json({
                error: 'Only the family creator can delete this family'
            });
        }

        const deleted = await familyService.deleteFamily(
            req.params.id
        );

        if (!deleted) {
            return res.status(404).json({
                error: 'Family not found'
            });
        }

        res.status(204).send();

    } catch (err) {
        console.error(err);

        res.status(500).json({
            error: 'Something went wrong'
        });
    }
}

export async function inviteMember(req, res) {
    try {
        const familyId = req.params.id;

        // FAMILY MANAGER / CREATOR ONLY
        const isCreator = await familyService.isFamilyCreator(
            familyId,
            req.user.user_id
        );

        if (!isCreator) {
            return res.status(403).json({
                error: 'Only the family creator can invite members'
            });
        }

        const { phone_number, relation } = req.body;

        const invite = await invitationService.inviteMember(
            familyId,
            phone_number,
            relation
        );

        res.status(201).json(invite);

    } catch (err) {
        if (err.code === 'USER_NOT_FOUND') {
            return res.status(404).json({
                error: err.message
            });
        }

        if (
            err.code === 'ALREADY_MEMBER' ||
            err.code === 'ALREADY_PENDING'
        ) {
            return res.status(409).json({
                error: err.message
            });
        }

        console.error(err);

        res.status(500).json({
            error: 'Something went wrong'
        });
    }
}

export async function removeMember(req, res) {
    try {
        const { id: familyId, memberId } = req.params;

        // FAMILY MANAGER / CREATOR ONLY
        const isCreator = await familyService.isFamilyCreator(
            familyId,
            req.user.user_id
        );

        if (!isCreator) {
            return res.status(403).json({
                error: 'Only the family creator can remove members'
            });
        }

        const removed = await familyService.removeMember(
            familyId,
            memberId,
            req.user.user_id
        );

        if (!removed) {
            return res.status(404).json({
                error: 'Accepted member not found'
            });
        }

        res.status(204).send();

    } catch (err) {
        if (err.code === 'CANNOT_REMOVE_CREATOR') {
            return res.status(403).json({
                error: err.message
            });
        }

        console.error(err);

        res.status(500).json({
            error: 'Something went wrong'
        });
    }
}