# Changelog

## rcamelspe 0.1.0

- Initial release of the package.
- Added functions to download and load the CAMELS-PE dataset:
  - [`download_pe_data()`](https://pefrens.github.io/rcamelspe/reference/download_pe_data.md)
    to download and extract Zenodo files.
  - [`load_pe_metadata()`](https://pefrens.github.io/rcamelspe/reference/load_pe_metadata.md)
    to load gauging station metadata and data dictionary.
  - [`load_pe_attributes()`](https://pefrens.github.io/rcamelspe/reference/load_pe_attributes.md)
    to load and merge static catchment attributes.
  - [`load_pe_timeseries()`](https://pefrens.github.io/rcamelspe/reference/load_pe_timeseries.md)
    to efficiently load daily hydroclimatic timeseries (with
    dual-reading strategy using `arrow` and `collapse`).
  - [`load_pe_geospatial()`](https://pefrens.github.io/rcamelspe/reference/load_pe_geospatial.md)
    to load catchment polygons and gauge coordinates.
- Added plotting utilities:
  - [`plot_pe_timeseries()`](https://pefrens.github.io/rcamelspe/reference/plot_pe_timeseries.md)
    for timeseries visualization.
  - [`plot_pe_catchments()`](https://pefrens.github.io/rcamelspe/reference/plot_pe_catchments.md)
    for boundaries/gauge map visualization.
  - [`plot_pe_attribute_map()`](https://pefrens.github.io/rcamelspe/reference/plot_pe_attribute_map.md)
    for attribute thematic maps.
