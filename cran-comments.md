## Test environments
* local Windows 11 x64, R 4.6.1
* win-builder (devel and release)

## R CMD check results
There were no ERRORs, WARNINGs, or NOTEs.

0 errors | 0 warnings | 0 notes

## Initial Submission Notes
* This is a new release of `rcamelspe`.
* The package provides a high-performance interface to download, load, and manage
  the CAMELS-PE (Catchment Attributes and Meteorology for Large-Sample Studies - Peru)
  dataset distributed via Zenodo (DOI: 10.5281/zenodo.20058779).
* A minimal self-contained sample dataset (~120 KB) is bundled in `inst/extdata/sample_camels_pe`
  to ensure all function examples and tests execute autonomously within CRAN check limits.
