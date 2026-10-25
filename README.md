# MathWorks Minidrone Competition India 2026 - Team Repo

Round 1 (simulation) due **5 Nov 2026**. Round 2 (PX4 hardware): 26-27 Nov 2026, Bangalore.
Target: line following on the red track, then landing on the marker.

## Team
- Arya - GitHub, flight control, integration
- Wamika - perception and validation

## Requirements
- MATLAB R2026a + Simulink
- Toolboxes / support packages (confirm against the official starter project):
  - Simulink Support Package for Parrot Minidrones
  - Aerospace Blockset
  - UAV Toolbox
  - Computer Vision Toolbox
  - Image Processing Toolbox
  - Embedded Coder / MATLAB Coder (code-generation check)

Check what is installed with `ver` in MATLAB.

## Setup
1. `git clone https://github.com/Aryakuna14/drone-sim-arya`
2. Open MATLAB, `cd` into `starter/`, open the project (`.prj`) or run the starter script.
3. Run the untouched model and log any errors in `docs/baseline.md`.

## Layout
- `starter/`   official starter project (untouched, tag `baseline`)
- `docs/`      baseline results, system map, test logs
- `tests/`     test scripts and recorded results

## Workflow
- `main` = last known-good version. Do not edit `.slx` files directly on `main`.
- `arya/controller` - Arya's experiments; `wamika/perception` - Wamika's experiments.
- **Simulink files cannot be merged.** Only one person edits a given `.slx` at a time; agree before merging.
- Commit results with the parameters used. Tag known-good versions (`good-YYYYMMDD`).

## Schedule
24 Oct setup - 25-26 Oct map and baseline - 27-29 Oct experiments - 30-31 Oct integrate - 1 Nov codegen - 2 Nov freeze - 4 Nov submit.
