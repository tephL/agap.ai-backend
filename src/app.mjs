import express from 'express';
import dotenv from 'dotenv';
dotenv.config();
import authRoute from '#/routes/authRoutes.mjs';
import peopleRoute from '#/routes/peopleRoutes.mjs';

export const DEV = process.env.DEV;
const PORT = DEV ? 3000 : process.env.PORT;

const app = express();
app.use(express.json());
app.use('/api/auth', authRoute);
app.use('/api/people', peopleRoute);

app.listen(PORT, () => {
    console.log(`running at port: ${PORT}`);
    console.log(DEV ? 'DEVELOPMENT mode' : 'PRODUCTION mode');
});
