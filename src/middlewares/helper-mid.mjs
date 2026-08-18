import { validationResult } from "express-validator";
import { verifyToken } from "#/services/jwtHelper.mjs";

export function catchValidationError(req, res, next) {
    const errors = validationResult(req);
        if (!errors.isEmpty()) {
        return res.status(400).json(errors.array());
    }
    next();
}

export function isUserLoggedIn(req, res, next){
    const rawHeader = req.headers.cookie;
    // TODO: add a condition for expo auth too
    if(!rawHeader) return res.sendStatus(401);

    const token = rawHeader.split('=')[1];
    const decoded = verifyToken(token);
    next();
}
