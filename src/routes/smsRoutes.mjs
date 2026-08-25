import express, { Router } from 'express';
import { configDotenv } from 'dotenv';
configDotenv();
import * as userServ from '#/services/userServ.mjs';
import * as reportServ from '#/services/reportServ.mjs';
import * as clusterServ from '#/services/clusterServ.mjs';

const router = Router();
router.use(express.raw({ type: 'application/json' }));

router.post('', 
  async (req, res) => {
    try {
      const { body: data } = req;
      const [lngStr, latStr, description] = data.message.split('|').map(s => s.trim());
      const longitude = parseFloat(lngStr);
      const latitude = parseFloat(latStr);
      if(lngStr === undefined ||
        latStr === undefined ||
        isNaN(lngStr) ||
        isNaN(latStr)
      ){
        return res.sendStatus(200);
      }

      const senderNoCountryCode = data.sender.replace(/^\+63/, '');
      const { user_id } = await userServ.getUserWithPhone(senderNoCountryCode);
      await reportServ.logReportWithCoordinates({ longitude, latitude, user_id });

      const report = await reportServ.logReportWithCoordinates({ latitude, longitude, user_id });
      const { report_id } = report;

      let nearest = await clusterServ.getNearestCluster({ latitude, longitude });

      if (!nearest) {
        const city_id = await userServ.getCityIdForUser(user_id);
        nearest = await clusterServ.createCluster({
          latitude,
          longitude,
          city_id,
          people_affected: report.people_affected ?? 0,
        });
      }

      const { cluster_id } = nearest;
      await clusterServ.assignReportToCluster({ report_id, cluster_id, reported_by: user_id });
      await clusterServ.updateClusterStats(cluster_id);
      // moving the report may have emptied its previous cluster — sweep now
      // instead of waiting for the periodic cleanup job
      await clusterServ.deleteClustersWithoutReports();

      if(description){
        await reportServ.attachDescriptionToReport({ report_id, description });
      }

      console.log('success!');
      res.sendStatus(200);
    } catch(e){
      console.log(e);
      return res.sendStatus(500);
    }
  }
);

export default router;
