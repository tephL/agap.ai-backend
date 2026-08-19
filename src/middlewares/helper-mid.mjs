import { validationResult } from "express-validator";
import { verifyToken } from "#/services/jwtHelper.mjs";

export function catchValidationError(req, res, next) {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
        return res.status(400).json(errors.array());
    }

    next();
}

export function isUserLoggedIn(req, res, next) {
    try {
        const rawHeader = req.headers.cookie;

        if (!rawHeader) {
            return res.sendStatus(401);
        }

        const match = rawHeader.match(/token=([^;]+)/);

        if (!match) {
            return res.sendStatus(401);
        }

        const decoded = verifyToken(match[1]);

        req.user = decoded;
        next();
    } catch (err) {
        return res.sendStatus(401);
    }
}

export function whoIsUser(req) {
    const rawHeader = req.headers.cookie;

    // TODO: add a getter for expo clients
    if (!rawHeader) return null;

    const match = rawHeader.match(/token=([^;]+)/);

    if (!match) return null;

    return verifyToken(match[1]);
}