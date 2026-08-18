import bcrypt from "bcrypt";

const SALT_ROUNDS = 10;

export function hashPassword(plainPassword) {
    return bcrypt.hashSync(plainPassword, SALT_ROUNDS);
}

export function comparePassword(plainPassword, hashedPassword) {
    return bcrypt.compareSync(plainPassword, hashedPassword);
}
