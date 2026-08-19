import * as invitationService from '#/services/invitation.service.mjs';

export async function getMyInvitations(req, res) {
  try {
    const invitations = await invitationService.getMyInvitations(req.user.user_id);
    res.status(200).json(invitations);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Something went wrong' });
  }
}

export async function acceptInvitation(req, res) {
  try {
    const accepted = await invitationService.acceptInvitation(req.params.id, req.user.user_id);
    if (!accepted) return res.status(404).json({ error: 'Invitation not found' });
    res.status(200).json(accepted);
  } catch (err) {
    if (err.code === 'ALREADY_MEMBER') return res.status(409).json({ error: err.message });
    console.error(err);
    res.status(500).json({ error: 'Something went wrong' });
  }
}

export async function rejectInvitation(req, res) {
  try {
    const rejected = await invitationService.rejectInvitation(req.params.id, req.user.user_id);
    if (!rejected) return res.status(404).json({ error: 'Invitation not found' });
    res.status(200).json(rejected);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Something went wrong' });
  }
}