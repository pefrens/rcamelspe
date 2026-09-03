# Changelog

## rcamelspe 0.1.0

- Initial release of `rcamelspe`.
- High-performance data reading engine:
  - Uses
    [`arrow::open_dataset()`](https://arrow.apache.org/docs/r/reference/open_dataset.html)
    with predicate pushdown and column projection for lightning-fast
    querying and minimal memory overhead on the 186 MB daily
    hydroclimate database.
  - Added `start_date` and `end_date` parameters to
    [`load_pe_timeseries()`](https://pefrens.github.io/rcamelspe/reference/load_pe_timeseries.md)
    for temporal slicing at scan time.
  - Accelerated
    [`load_pe_attributes()`](https://pefrens.github.io/rcamelspe/reference/load_pe_attributes.md)
    by filtering target gauges prior to relational joining with
    [`collapse::join()`](https://fastverse.org/collapse/reference/join.html).
- Drop-in compatibility with `RCamelsPE`:
  - Added function aliases
    [`read_timeseries()`](https://pefrens.github.io/rcamelspe/reference/read_timeseries.md),
    [`read_attributes()`](https://pefrens.github.io/rcamelspe/reference/read_attributes.md),
    [`read_metadata()`](https://pefrens.github.io/rcamelspe/reference/read_metadata.md),
    [`read_dictionary()`](https://pefrens.github.io/rcamelspe/reference/read_dictionary.md),
    [`read_geospatial()`](https://pefrens.github.io/rcamelspe/reference/read_geospatial.md),
    [`download_camels_pe()`](https://pefrens.github.io/rcamelspe/reference/download_camels_pe.md),
    [`set_camels_path()`](https://pefrens.github.io/rcamelspe/reference/set_camels_pe_path.md),
    [`get_camels_path()`](https://pefrens.github.io/rcamelspe/reference/get_camels_pe_path.md),
    [`plot_timeseries()`](https://pefrens.github.io/rcamelspe/reference/plot_pe_timeseries.md),
    [`plot_catchments()`](https://pefrens.github.io/rcamelspe/reference/plot_pe_catchments.md),
    and
    [`plot_attribute_map()`](https://pefrens.github.io/rcamelspe/reference/plot_pe_attribute_map.md).
- Bundled sample dataset:
  - Added a lightweight self-contained sample dataset in
    `inst/extdata/sample_camels_pe` (~120 KB) enabling autonomous
    execution of examples and tests without requiring external internet
    downloads.
- Added visualization utilities:
  - [`plot_pe_timeseries()`](https://pefrens.github.io/rcamelspe/reference/plot_pe_timeseries.md)
    with curated color palette and faceting options.
  - [`plot_pe_catchments()`](https://pefrens.github.io/rcamelspe/reference/plot_pe_catchments.md)
    for boundaries and gauging station spatial inspection.
  - [`plot_pe_attribute_map()`](https://pefrens.github.io/rcamelspe/reference/plot_pe_attribute_map.md)
    for choropleth mapping of catchment attributes.
