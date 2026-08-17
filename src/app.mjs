import express from 'express';
import dotenv from 'dotenv';
dotenv.config();

const DEV = process.env.DEV;
const PORT = DEV ? 3000 : process.env.PORT;

const app = express();

app.listen(PORT, () => {
    console.log(`running at port: ${PORT}`);
    console.log(DEV ? 'DEVELOPMENT mode' : 'PRODUCTION mode');
});
