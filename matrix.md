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

The person profile (`fetchReporterDetails`, `aiAnalysisServ.mjs:120`) feeds these **vulnerability factors** into severity estimation at `geminiServ.mjs:89`:

- age (elderly/children = higher risk)
- gender
- city/barangay
- **disabilities**
- **pets**
- **house_floors** (living on low floor = more flood risk)

**Output per report** (JSON): `ai_summary`, `ai_disaster_type`, `ai_severity` (critical/high/medium/low), `ai_people_estimate` (int), `ai_action_plan` (array).

## Stage 2 — Report-to-cluster assignment

`clusterServ`

Reports are grouped into a **cluster** via `getNearestCluster` (within **400m EPS_METERS**, `clusterServ.mjs:3`) or a new cluster is created. Each report is linked via `report_clusters`.

## Stage 3 — Cluster aggregation & priority

`aiAnalysisServ.reevaluateCluster`

All reports in a cluster are re-analyzed together. Two paths compute the cluster summary.

### A. Deterministic fallback

`computeClusterStats`, `aiAnalysisServ.mjs:183` — always runs:

- `totalPeople` = Σ individual `ai_people_estimate`
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
| `high` | ≥ 3 | **or** ≥ 20 | **high** |
| — | ≥ 3 | **or** ≥ 8 | **medium** |
| else (low/medium, low volume) | | | **low** |

**Logic** (SQL mirror in `updateClusterStats`, `clusterServ.mjs:236`):

- **critical** alone always escalates to `high` (life-threatening)
- **high + scale** (many reports **or** many people) → `high`
- moderate **volume/scale** (≥3 reports **or** ≥8 people) → `medium`
- everything else → `low`

## Key insights

1. **Severity is the dominant axis** — a critical report is `high` priority regardless of how few people/reports.
2. **Volume/scale acts as a multiplier** — many small reports or a high people-count push lower severities up.
3. **People are weighted both ways** — `people_affected = GREATEST(people_sum, ai_people_sum)` in `clusterServ.mjs:235`, so clusters take the *larger* of human-reported vs AI-estimated affected counts.
4. **Priority is stored on the cluster** (`clusters.priority_level`), so dispatchers see the aggregate rather than per-report severity.
5. **Vulnerability feeds bottom-up** — a disabled/elderly/pet-owning reporter in a low-floor home nudges their *individual* severity up (`geminiServ.mjs:89`), which then raises `maxSeverity`, which can escalate cluster priority.
