import { matchedData } from "express-validator";
import * as dispatcherServ from "#/services/dispatcherServ.mjs";

function sendError(res, err, fallbackMessage) {
    const statusCode = err.statusCode ?? 500;
    if (statusCode === 500) console.log(err);
    return res.status(statusCode).json({ error: err.message ?? fallbackMessage });
}

// ------------------------------------------------------------------
// Teams
// ------------------------------------------------------------------

export async function getTeams(req, res) {
    try {
        return res.json({ teams: await dispatcherServ.getTeams() });
    } catch (err) {
        return sendError(res, err, "Failed to load teams");
    }
}

export async function createTeam(req, res) {
    try {
        const data = matchedData(req);
        const team = await dispatcherServ.createTeam({
            name: data.name,
            contact_number: data.contact_number,
            location_text: data.location_text,
            latitude: data.latitude,
            longitude: data.longitude,
        });
        return res.status(201).json({ team });
    } catch (err) {
        return sendError(res, err, "Failed to create team");
    }
}

export async function getTeamAssignment(req, res) {
    try {
        const teamId = Number(req.params.teamId);
        const team = await dispatcherServ.getTeamById(teamId);
        if (!team) return res.status(404).json({ error: "Team not found" });

        const assignment = await dispatcherServ.getAssignmentForTeam(teamId);
        return res.json({ assignment });
    } catch (err) {
        return sendError(res, err, "Failed to load assignment");
    }
}

// ------------------------------------------------------------------
// Clusters
// ------------------------------------------------------------------

export async function getClusters(req, res) {
    try {
        // Default to open clusters — dispatchers work the live queue.
        const { status = "open" } = matchedData(req, { locations: ["query"] });
        return res.json({ clusters: await dispatcherServ.getClusters({ status }) });
    } catch (err) {
        return sendError(res, err, "Failed to load clusters");
    }
}

export async function updateClusterStatus(req, res) {
    try {
        const clusterId = Number(req.params.id);
        const { status } = matchedData(req);

        const cluster = await dispatcherServ.setClusterStatus(clusterId, status);
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
        const { team_id, cluster_id } = matchedData(req);
        const assignment = await dispatcherServ.createAssignment({
            team_id,
            cluster_id,
        });
        return res.status(201).json({ assignment });
    } catch (err) {
        return sendError(res, err, "Failed to assign team");
    }
}

export async function updateAssignmentStatus(req, res) {
    try {
        const assignmentId = Number(req.params.id);
        const { status } = matchedData(req);

        const assignment = await dispatcherServ.updateAssignmentStatus(
            assignmentId,
            status
        );
        return res.json({ assignment });
    } catch (err) {
        return sendError(res, err, "Failed to update assignment");
    }
}
