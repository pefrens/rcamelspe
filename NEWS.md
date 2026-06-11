# rcamelspe 0.1.0

* Initial release of the package.
* Added functions to download and load the CAMELS-PE dataset:
  * `download_pe_data()` to download and extract Zenodo files.
  * `load_pe_metadata()` to load gauging station metadata and data dictionary.
  * `load_pe_attributes()` to load and merge static catchment attributes.
  * `load_pe_timeseries()` to efficiently load daily hydroclimatic timeseries (with dual-reading strategy using `arrow` and `collapse`).
  * `load_pe_geospatial()` to load catchment polygons and gauge coordinates.
* Added plotting utilities:
  * `plot_pe_timeseries()` for timeseries visualization.
  * `plot_pe_catchments()` for boundaries/gauge map visualization.
  * `plot_pe_attribute_map()` for attribute thematic maps.
