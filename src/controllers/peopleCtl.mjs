import { matchedData } from "express-validator";
import { whoIsUser } from "#/middlewares/helper-mid.mjs";
import * as peopleServ from '#/services/peopleServ.mjs';

export async function createPersonalDetails(req, res){
    try{
        const details = matchedData(req);
        const { user_id } = whoIsUser(req);
        const person = await peopleServ.createPersonalDetails({ user_id, ...details });
        if(person) return res.sendStatus(201);
        return res.sendStatus(400);
    } catch(err){
        console.log(err);
        return res.sendStatus(500);
    }
}

export async function getPersonById(req, res){
    try{
        const { person_id } = req.params;
        const person = await peopleServ.getPersonById(person_id);
        if(person == undefined) return res.sendStatus(204);
        return res.status(200).json(person);
    } catch(err){
        console.log(err);
        return res.sendStatus(500);
    }
}

export async function editPersonById(req, res){
    try{
        const { person_id } = req.params;
        const updates = matchedData(req);
        const { user_id } = whoIsUser(req);

        const personBelongsToUser = await peopleServ.isPersonOwnedByUser({ user_id, person_id });
        if(!personBelongsToUser) return res.sendStatus(403);
        if(Object.entries(updates).length == 0) return res.status(400).json({ message: "Nothing to update" });

        const person = await peopleServ.editPersonDetails({ person_id, ...updates });
        return res.sendStatus(201);
    } catch(err){
        console.log(err);
        return res.sendStatus(500);
    }
}
