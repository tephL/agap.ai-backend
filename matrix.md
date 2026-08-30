# AI Report-to-Cluster Priority Matrix

How the AI analyzes reports from different people and determines a cluster's priority level.

The pipeline has three stages: **individual report analysis → cluster aggregation → priority classification**.

## Stage 1 — Individual report analysis

`aiAnalysisServ.analyzeReport` → `geminiServ`

Each report is analyzed by Gemini combining **what happened** with **who reported it**:

| Input | Source | Used to influence |
|-------|--------|-------------------|
| Images (1–3, via Cloudinary) | `report.images` | visual severity assessment |
| `description` (text) | report | disaster type, severity |
| `location` (lat/lng) | report coords | geographic context |
| `personDetails` | reporter's `people` profile | **vulnerability weighting** |

The person profile (`fetchReporterDetails`, `aiAnalysisServ.mjs:120`) feeds these **vulnerability factors** into severity estimation at `geminiServ.mjs`:

- age (elderly/children = higher risk)
- gender (used **conservatively** — only with a specific, justified risk such as pregnancy; never alone)
- city/barangay
- **disabilities**
- **pets**
- **house_floors** (living on low floor = more flood risk)

If no profile exists (anonymous/incomplete report), the vulnerability context is omitted and severity is treated as **neutral** — the model is told not to lower severity on unknown reporter data.

**Output per report** (JSON): `ai_summary`, `ai_disaster_type`, `ai_severity` (critical/high/medium/low), `ai_people_estimate` (int), `ai_action_plan` (array).

## Stage 2 — Report-to-cluster assignment

`clusterServ`

Reports are grouped into a **cluster** via `getNearestCluster` (within `CLUSTER_RADIUS_M`, default **400m**, `clusterServ.mjs:5`) or a new cluster is created. Each report is linked via `report_clusters`.

## Stage 3 — Cluster aggregation & priority

`aiAnalysisServ.reevaluateCluster`

All reports in a cluster are re-analyzed together. Two paths compute the cluster summary.

### A. Deterministic fallback

`computeClusterStats`, `aiAnalysisServ.mjs:183` — always runs:

- `totalPeople` = max individual `ai_people_estimate` (de-duplicated, not summed)
- `maxSeverity` = highest severity rank (`SEVERITY_RANK` = critical:4, high:3, medium:2, low:1)
- `dominantType` = most frequent disaster type
- `actionPlan` = deduped union of actions (max 10)
- `mergedSummaries` = concatenated summaries

### B. Gemini cluster synthesis

`analyzeCluster` — enriches with strategic overview, patterns, and nuances.

## The Priority Matrix

`computePriority`, `aiAnalysisServ.mjs:227`

Core decision table combining **severity × volume × scale**:

| maxSeverity | reportCount | totalPeople | → Priority |
|-------------|-------------|-------------|------------|
| `critical` | any | any | **high** |
| `high` | any | any | **high** |
| `medium` | ≥ 3 | **or** ≥ 8 | **high** |
| low/medium | ≥ 3 | **or** ≥ 8 | **medium** |
| else (low volume, low severity) | | | **low** |

**Logic** (SQL mirror in `updateClusterStats`, `clusterServ.mjs:239`):

- **critical or high** → `high` regardless of volume or scale (severity is the dominant axis — an isolated high-severity report is no longer downgraded)
- **medium + scale** (≥3 reports **or** ≥8 people) → `high`
- moderate **volume/scale** (≥3 reports **or** ≥8 people) → `medium`
- everything else → `low`

**People count is de-duplicated** using the *max* individual estimate rather than the sum (`aiAnalysisServ.mjs:191`), so multiple callers about the same incident do not inflate the count.

## Key insights

1. **Severity is the dominant axis** — critical *and* high reports are `high` priority regardless of how few people/reports.
2. **Volume/scale acts as a multiplier** — many reports or a high people-count push medium severity up to `high`, and low to `medium`.
3. **People counts are de-duplicated** — `people_affected = GREATEST(people_sum, ai_people_max)` in `clusterServ.mjs:238` uses the *max* AI estimate (not the sum) to avoid double-counting the same incident, and takes the larger of human-reported vs AI-estimated affected counts.
4. **Priority is stored on the cluster** (`clusters.priority_level`), so dispatchers see the aggregate rather than per-report severity.
5. **Vulnerability feeds bottom-up** — age, disability, pets, house floors, and (conservatively) gender nudge an individual's severity up (`geminiServ.mjs`), which then raises `maxSeverity`, which can escalate cluster priority. When no reporter profile exists, severity is treated as **neutral** (not lowered), and the model is instructed not to add/subtract on unknown data.

## Resolved gaps

- **Isolated high report no longer collapses to `low`** — high severity is now always `high` priority (`aiAnalysisServ.mjs:227`, `clusterServ.mjs:240`).
- **Double-counting of affected people removed** — uses `max` of AI estimates instead of `sum` (`aiAnalysisServ.mjs:191`, `clusterServ.mjs:258`).
- **Missing reporter profile handled explicitly** — model gets neutral guidance instead of silently skipping vulnerability (`geminiServ.mjs`).
- **Vulnerability weighting documented** in the prompt, including the rationale for gender; gender is to be used conservatively and never alone to raise severity.
- **Cluster radius is configurable** via `CLUSTER_RADIUS_M` (default 400m) so operators can tune for urban vs rural density (`clusterServ.mjs:5`).

## Out of scope

- **Staleness/time-decay** (priority downgrade when reports stop) — intentionally not addressed here.
