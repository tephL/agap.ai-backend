import * as helperMid from '#/middlewares/helper-mid.mjs';
import * as clusterServ from '#/services/clusterServ.mjs';

export async function getClustersOfMyCity(req, res){
  try{
    const { user_id } = helperMid.whoIsUser(req);
    const clusters = await clusterServ.getClustersFromCityOfDispatcher(user_id);
    return res.status(200).json(clusters);
  } catch(e){
    console.log(e);
    return res.sendStatus(500);
  }
}

export async function getReportsInCluster(req, res){
  try{
    const { user_id } = helperMid.whoIsUser(req);
    const cluster_id = Number(req.params.id);

    const data = await clusterServ.getReportsInCluster({ user_id, cluster_id });
    if (!data) return res.status(404).json({ message: "Cluster not found in your city" });

    return res.status(200).json(data);
  } catch(e){
    console.log(e);
    return res.sendStatus(500);
  }
}
