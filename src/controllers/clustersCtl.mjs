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
