import { validationResult } from "express-validator";
import { verifyToken } from "#/services/jwtHelper.mjs";

function extractToken(req) {
    const rawHeader = req.headers.cookie;
    if (rawHeader) {
        const match = rawHeader.match(/token=([^;]+)/);
        if (match) return match[1];
    }

    const authHeader = req.headers.authorization;
    if (authHeader && authHeader.startsWith("Bearer ")) {
        return authHeader.slice(7);
    }

    return null;
}

export function catchValidationError(req, res, next) {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
        return res.status(400).json(errors.array());
    }

    next();
}

export function isUserLoggedIn(req, res, next) {
    try {
        const token = extractToken(req);
        if (!token) return res.sendStatus(401);

        const decoded = verifyToken(token);
        req.user = decoded;
        next();
    } catch (err) {
        return res.sendStatus(401);
    }
}

export function whoIsUser(req) {
    const token = extractToken(req);
    if (!token) return null;

    try {
        return verifyToken(token);
    } catch {
        return null;
    }
}