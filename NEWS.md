# rcamelspe (development version)

- Replace the five-catchment routing cutoff with a CSV-size and opening-cost
  estimate, avoiding unnecessary national scans for medium-sized selections.
  Missing individual files fall back to the master; selections also work when
  only individual CSVs are installed. Repeated gauge IDs are deduplicated.
- Bind individual time-series tables with `dplyr::bind_rows()` to avoid corrupt
  result attributes encountered in repeated larger batches with `collapse::rowbind()`.

- Default downloads now use CAMELS-PE 1.0.1 (Zenodo 21195425); 1.0 remains selectable.
- Download wrappers honor `version` and `set_path`. Archive-only downloads return
  the ZIP path and do not configure an unextracted data directory.
- Failed downloads no longer leave a partial file under the cached archive name.
- Time-series wrappers honor `global`, accept identifier columns and validate date bounds.
- Document all ten daily variables, units, sources, coverage, simulated signatures,
  dataset attribution and the distinction from the upstream RCamelsPE package.

# rcamelspe 0.1.0

* Initial release of `rcamelspe`.
* High-performance data reading engine:
  * Uses `arrow::open_dataset()` with predicate pushdown and column projection for lightning-fast querying and minimal memory overhead on the 186 MB daily hydroclimate database.
  * Added `start_date` and `end_date` parameters to `load_pe_timeseries()` for temporal slicing at scan time.
  * Accelerated `load_pe_attributes()` by filtering target gauges prior to relational joining with `collapse::join()`.
* Drop-in compatibility with `RCamelsPE`:
  * Added function aliases `read_timeseries()`, `read_attributes()`, `read_metadata()`, `read_dictionary()`, `read_geospatial()`, `download_camels_pe()`, `set_camels_path()`, `get_camels_path()`, `plot_timeseries()`, `plot_catchments()`, and `plot_attribute_map()`.
* Bundled sample dataset:
  * Added a lightweight self-contained sample dataset in `inst/extdata/sample_camels_pe` (~120 KB) enabling autonomous execution of examples and tests without requiring external internet downloads.
* Added visualization utilities:
  * `plot_pe_timeseries()` with curated color palette and faceting options.
  * `plot_pe_catchments()` for boundaries and gauging station spatial inspection.
  * `plot_pe_attribute_map()` for choropleth mapping of catchment attributes.
