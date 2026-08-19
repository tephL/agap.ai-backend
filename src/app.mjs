import express from 'express';
import { DEV } from '#/config/env.mjs'
import authRoute from '#/routes/authRoutes.mjs';
import peopleRoute from '#/routes/peopleRoutes.mjs';
import familyRoutes from '#/routes/family.routes.mjs';
import invitationRoutes from '#/routes/invitationRoutes.mjs';
import reportRoutes from '#/routes/reportRoutes.mjs';

import cors from '#/config/cors.mjs';

const PORT = DEV ? 3000 : process.env.PORT;

const app = express();
app.use(express.json());
app.use(cors);

app.use('/api/auth', authRoute);
app.use('/api/people', peopleRoute);
app.use('/api/families', familyRoutes);
app.use('/api/invitations', invitationRoutes);
app.use('/api/reports', reportRoutes);

app.use((req, res) => res.sendStatus(404));

app.listen(PORT, () => {
console.log(`running at port: ${PORT}`);
console.log(DEV ? 'DEVELOPMENT mode' : 'PRODUCTION mode');
});
