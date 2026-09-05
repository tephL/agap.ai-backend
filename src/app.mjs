import express from 'express';
import { DEV } from '#/config/env.mjs'
import authRoute from '#/routes/authRoutes.mjs';
import smsRoute from '#/routes/smsRoutes.mjs';
import peopleRoute from '#/routes/peopleRoutes.mjs';
import familyRoutes from '#/routes/family.routes.mjs';
import invitationRoutes from '#/routes/invitationRoutes.mjs';
import reportRoutes from '#/routes/reportRoutes.mjs';
import userRoutes from '#/routes/userRoutes.mjs';
import clusterRoutes from '#/routes/clustersRoute.mjs';
import dispatcherRoutes from '#/routes/dispatcher.routes.mjs';
import myAssignmentsRoute from '#/routes/myAssignments.route.mjs';
import publicTeamsRoute from '#/routes/publicTeams.route.mjs';
import aiAssistantRoutes from '#/routes/aiAssistant.routes.mjs';
import typhoonRoutes from '#/routes/typhoonRoutes.mjs';
import elevationRoutes from '#/routes/elevationRoutes.mjs';

import cors from '#/config/cors.mjs';
import { startClusterCleanupJob } from '#/jobs/clusterCleanupJob.mjs';

const PORT = DEV ? 3000 : process.env.PORT;

const app = express();
app.use(express.json());
app.use(cors);

app.use('/api/auth', authRoute);
app.use('/api/sms', smsRoute);
app.use('/api/people', peopleRoute);
app.use('/api/users', userRoutes);
app.use('/api/families', familyRoutes);
app.use('/api/invitations', invitationRoutes);
app.use('/api/reports', reportRoutes);
app.use('/api/dispatcher', dispatcherRoutes);
app.use('/api/clusters', clusterRoutes);
app.use('/api/my-assignments', myAssignmentsRoute);
app.use('/api/public-teams', publicTeamsRoute);
app.use('/api/ai', aiAssistantRoutes);
app.use('/api/typhoons', typhoonRoutes);
app.use('/api/elevation', elevationRoutes);
app.get('/hp', (req, res) => { return res.sendStatus(200) });
app.use((req, res) => res.sendStatus(404));

app.listen(PORT, () => {
console.log(`running at port: ${PORT}`);
console.log(DEV ? 'DEVELOPMENT mode' : 'PRODUCTION mode');
startClusterCleanupJob();
});
