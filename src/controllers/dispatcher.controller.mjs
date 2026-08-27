import { matchedData } from "express-validator";
import * as dispatcherServ from "#/services/dispatcherServ.mjs";
import * as userServ from "#/services/userServ.mjs";
import { whoIsUser } from "#/middlewares/helper-mid.mjs";

function sendError(res, err, fallbackMessage) {
    const statusCode = err.statusCode ?? 500;
    if (statusCode === 500) console.log(err);
    return res.status(statusCode).json({ error: err.message ?? fallbackMessage });
}

// Every dispatcher route is scoped to the caller's city. The city is
// resolved per request from users -> people -> cities (name match);
// a null result means the account has no resolvable city.
async function cityOfDispatcher(req) {
    const session = whoIsUser(req);
    if (!session?.user_id) return null;
    return userServ.getCityIdForUser(session.user_id);
}

// ------------------------------------------------------------------
// Teams
// ------------------------------------------------------------------

export async function getTeams(req, res) {
    try {
        const cityId = await cityOfDispatcher(req);
        if (!cityId) return res.json({ teams: [] });
        return res.json({ teams: await dispatcherServ.getTeams(cityId) });
    } catch (err) {
        return sendError(res, err, "Failed to load teams");
    }
}

export async function createTeam(req, res) {
    try {
        const cityId = await cityOfDispatcher(req);
        if (!cityId) {
            return res.status(409).json({ error: "Your account has no city on file" });
        }

        const data = matchedData(req);
        const team = await dispatcherServ.createTeam(
            {
                name: data.name,
                contact_number: data.contact_number,
                latitude: data.latitude,
                longitude: data.longitude,
            },
            cityId
        );
        return res.status(201).json({ team });
    } catch (err) {
        return sendError(res, err, "Failed to create team");
    }
}

export async function getTeamAssignment(req, res) {
    try {
        const cityId = await cityOfDispatcher(req);
        if (!cityId) return res.status(404).json({ error: "Team not found" });

        const teamId = Number(req.params.teamId);
        const team = await dispatcherServ.getTeamById(teamId, cityId);
        if (!team) return res.status(404).json({ error: "Team not found" });

        const assignment = await dispatcherServ.getAssignmentForTeam(teamId);
        return res.json({ assignment });
    } catch (err) {
        return sendError(res, err, "Failed to load assignment");
    }
}

export async function updateTeam(req, res) {
    try {
        const cityId = await cityOfDispatcher(req);
        if (!cityId) return res.status(404).json({ error: "Team not found" });

        const teamId = Number(req.params.teamId);
        const { is_public } = matchedData(req);

        const team = await dispatcherServ.updateTeam(teamId, { is_public }, cityId);
        if (!team) return res.status(404).json({ error: "Team not found" });
        return res.json({ team });
    } catch (err) {
        return sendError(res, err, "Failed to update team");
    }
}

export async function relocateTeam(req, res) {
    try {
        const cityId = await cityOfDispatcher(req);
        if (!cityId) return res.status(404).json({ error: "Team not found" });

        const teamId = Number(req.params.teamId);
        const { latitude, longitude } = matchedData(req);

        const team = await dispatcherServ.relocateTeam(teamId, { latitude, longitude }, cityId);
        if (!team) return res.status(404).json({ error: "Team not found" });
        return res.json({ team });
    } catch (err) {
        return sendError(res, err, "Failed to relocate team");
    }
}

// ------------------------------------------------------------------
// Clusters
// ------------------------------------------------------------------

export async function getClusters(req, res) {
    try {
        // Default to open clusters — dispatchers work the live queue.
        const { status = "open" } = matchedData(req, { locations: ["query"] });
        const cityId = await cityOfDispatcher(req);
        if (!cityId) return res.json({ clusters: [] });
        return res.json({ clusters: await dispatcherServ.getClusters({ status }, cityId) });
    } catch (err) {
        return sendError(res, err, "Failed to load clusters");
    }
}

export async function updateClusterStatus(req, res) {
    try {
        const cityId = await cityOfDispatcher(req);
        if (!cityId) return res.status(404).json({ error: "Cluster not found" });

        const clusterId = Number(req.params.id);
        const { status } = matchedData(req);

        const cluster = await dispatcherServ.setClusterStatus(clusterId, status, cityId);
        if (!cluster) return res.status(404).json({ error: "Cluster not found" });
        return res.json({ cluster });
    } catch (err) {
        return sendError(res, err, "Failed to update cluster");
    }
}

// ------------------------------------------------------------------
// Assignments
// ------------------------------------------------------------------

export async function createAssignment(req, res) {
    try {
        const cityId = await cityOfDispatcher(req);
        if (!cityId) return res.status(404).json({ error: "Team not found" });

        const { team_id, cluster_id } = matchedData(req);
        const assignment = await dispatcherServ.createAssignment(
            { team_id, cluster_id },
            cityId
        );
        return res.status(201).json({ assignment });
    } catch (err) {
        return sendError(res, err, "Failed to assign team");
    }
}

export async function updateAssignmentStatus(req, res) {
    try {
        const cityId = await cityOfDispatcher(req);
        if (!cityId) return res.status(404).json({ error: "Assignment not found" });

        const assignmentId = Number(req.params.id);
        const { status } = matchedData(req);

        const assignment = await dispatcherServ.updateAssignmentStatus(
            assignmentId,
            status,
            cityId
        );
        return res.json({ assignment });
    } catch (err) {
        return sendError(res, err, "Failed to update assignment");
    }
}
