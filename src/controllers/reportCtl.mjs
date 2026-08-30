import { uploadImageToCloudinary } from "#/services/cloudinaryUploader.mjs";
import * as imageServ from '#/services/imageServices.mjs';
import * as helperMid from '#/middlewares/helper-mid.mjs';
import { matchedData } from "express-validator";
import { whoIsUser } from "#/middlewares/helper-mid.mjs";
import * as reportServ from "#/services/reportServ.mjs";
import * as clusterServ from '#/services/clusterServ.mjs';
import * as userServ from '#/services/userServ.mjs';
import * as aiAnalysisServ from '#/services/aiAnalysisServ.mjs';

const MIN_FILES = 1;
const MAX_FILES = 3;

export async function uploadReportedImage(req, res){
    if (!req.files || req.files.length < MIN_FILES) {
        return res.status(400).json({ message: `Please upload at least ${MIN_FILES} image` });
    }
    if (req.files.length > MAX_FILES) {
        return res.status(400).json({ message: `You can upload at most ${MAX_FILES} images` });
    }

    try {
        const { user_id } = helperMid.whoIsUser(req);
        const recent_report = await reportServ.getUserRecentReport({ user_id });
        console.log(recent_report);
        if(recent_report.length === 0) return res.status(400).json({ message: "No report to attach image to" });

        const { report_id } = recent_report[0];

        const isMaxImages = await imageServ.isMaxImagesProvided(report_id);
        if(isMaxImages) return res.status(400).json({ message: "You have sent your maximum images" });

        const uploadResults = await Promise.all(
            req.files.map(file => uploadImageToCloudinary(file.buffer))
        );

        const urls = uploadResults.map(result => result.url);
        await imageServ.logImageUploads({ urls, user_id, report_id });

        aiAnalysisServ.analyzeReport({ report_id }).catch(e =>
            console.error(`Background AI analysis failed for report ${report_id}:`, e.message)
        );

        return res.sendStatus(200);
    } catch(e){
        console.log(e);
        return res.status(500).json({ message: 'Upload failed' });
    }
}

export async function reportWithLocation(req, res) {
  try {
    const { latitude, longitude } = matchedData(req);
    const { user_id } = whoIsUser(req);

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

    aiAnalysisServ.analyzeReport({ report_id }).catch(e =>
        console.error(`Background AI analysis failed for report ${report_id}:`, e.message)
    );

    return res.sendStatus(200);
  } catch (e) {
    console.log(e);
    return res.sendStatus(500);
  }
}

export async function attachDescriptionToReport(req, res){
    try{
        const { description } = matchedData(req);
        const { user_id } = helperMid.whoIsUser(req);
        const recent_report = await reportServ.getUserRecentReport({ user_id });
        if(recent_report.length === 0) return res.status(400).json({ message: "No report to attach description to" });

        const { report_id } = recent_report[0];

        const attach = await reportServ.attachDescriptionToReport({ report_id, description });

        aiAnalysisServ.analyzeReport({ report_id }).catch(e =>
            console.error(`Background AI analysis failed for report ${report_id}:`, e.message)
        );

        return res.sendStatus(200);
    } catch(e){
        console.log(e);
        return res.sendStatus(500);
    }
}

export async function getReportById(req, res){
    try{
        const report_id = Number(req.params.reportId);
        if(!Number.isInteger(report_id) || report_id <= 0){
            return res.status(400).json({ message: "Invalid report id" });
        }

        const report = await reportServ.getReportDetailsById({ report_id });
        if(!report) return res.status(404).json({ message: "Report not found" });

        return res.status(200).json({ report });
    } catch(e){
        console.log(e);
        return res.sendStatus(500);
    }
}

export async function updateReportStatus(req, res){
    try{
        const report_id = Number(req.params.reportId);
        if(!Number.isInteger(report_id) || report_id <= 0){
            return res.status(400).json({ message: "Invalid report id" });
        }

        const { status } = matchedData(req);
        const updated = await reportServ.updateReportStatus({ report_id, status });
        if(!updated) return res.status(404).json({ message: "Report not found" });

        aiAnalysisServ.reevaluateClusterForReport({ report_id }).catch(e =>
            console.error(`Background cluster re-evaluation failed for report ${report_id}:`, e.message)
        );

        return res.status(200).json({ report: updated });
    } catch(e){
        console.log(e);
        return res.sendStatus(500);
    }
}
