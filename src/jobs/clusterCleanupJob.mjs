import * as clusterServ from '#/services/clusterServ.mjs';

// Periodically removes clusters that have no reports left attached to
// them (e.g. every report was reassigned elsewhere), so stale pins
// never show up on the dispatcher map.
const CLEANUP_INTERVAL_MS = 1000 * 60; // 1 min

let timer = null;

export async function runClusterCleanup(){
  try{
    const deletedIds = await clusterServ.deleteClustersWithoutReports();
    if(deletedIds.length > 0){
      console.log(`[clusterCleanup] removed ${deletedIds.length} empty cluster(s):`, deletedIds);
    }
    return deletedIds;
  } catch(e){
    console.log('[clusterCleanup] failed:', e.message);
    return [];
  }
}

export function startClusterCleanupJob(){
  if(timer) return;
  timer = setInterval(runClusterCleanup, CLEANUP_INTERVAL_MS);
  timer.unref();
}
