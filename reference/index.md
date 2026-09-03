# Package index

## Dataset Acquisition and Configuration

Functions to download, extract, and locate the CAMELS-PE dataset.

- [`download_pe_data()`](https://pefrens.github.io/rcamelspe/reference/download_pe_data.md)
  : Download the CAMELS-PE dataset from Zenodo
- [`set_camels_pe_path()`](https://pefrens.github.io/rcamelspe/reference/set_camels_pe_path.md)
  [`set_camels_path()`](https://pefrens.github.io/rcamelspe/reference/set_camels_pe_path.md)
  : Set the path to the CAMELS-PE dataset
- [`get_camels_pe_path()`](https://pefrens.github.io/rcamelspe/reference/get_camels_pe_path.md)
  [`get_camels_path()`](https://pefrens.github.io/rcamelspe/reference/get_camels_pe_path.md)
  : Get the path to the CAMELS-PE dataset

## Data Loading and Subsetting

High-performance reading of metadata, attributes, daily timeseries, and
geospatial layers.

- [`load_pe_metadata()`](https://pefrens.github.io/rcamelspe/reference/load_pe_metadata.md)
  : Load CAMELS-PE metadata
- [`load_pe_attributes()`](https://pefrens.github.io/rcamelspe/reference/load_pe_attributes.md)
  : Load CAMELS-PE catchment attributes
- [`load_pe_timeseries()`](https://pefrens.github.io/rcamelspe/reference/load_pe_timeseries.md)
  : Load CAMELS-PE daily timeseries data
- [`load_pe_geospatial()`](https://pefrens.github.io/rcamelspe/reference/load_pe_geospatial.md)
  : Load CAMELS-PE geospatial data

## Visualization and Mapping

Plotting utilities for hydrometeorological time series and spatial
catchment boundaries.

- [`plot_pe_timeseries()`](https://pefrens.github.io/rcamelspe/reference/plot_pe_timeseries.md)
  [`plot_timeseries()`](https://pefrens.github.io/rcamelspe/reference/plot_pe_timeseries.md)
  : Plot CAMELS-PE Time Series
- [`plot_pe_catchments()`](https://pefrens.github.io/rcamelspe/reference/plot_pe_catchments.md)
  [`plot_catchments()`](https://pefrens.github.io/rcamelspe/reference/plot_pe_catchments.md)
  : Plot CAMELS-PE Catchments
- [`plot_pe_attribute_map()`](https://pefrens.github.io/rcamelspe/reference/plot_pe_attribute_map.md)
  [`plot_attribute_map()`](https://pefrens.github.io/rcamelspe/reference/plot_pe_attribute_map.md)
  : Plot CAMELS-PE Attribute Map

## Compatibility Aliases (RCamelsPE Interface)

Drop-in functions matching the original RCamelsPE interface for seamless
migration.

- [`download_camels_pe()`](https://pefrens.github.io/rcamelspe/reference/download_camels_pe.md)
  : Download CAMELS-PE dataset from Zenodo
- [`read_metadata()`](https://pefrens.github.io/rcamelspe/reference/read_metadata.md)
  : Read CAMELS-PE station metadata
- [`read_dictionary()`](https://pefrens.github.io/rcamelspe/reference/read_dictionary.md)
  : Read CAMELS-PE data dictionary
- [`read_attributes()`](https://pefrens.github.io/rcamelspe/reference/read_attributes.md)
  : Read CAMELS-PE catchment attributes
- [`read_timeseries()`](https://pefrens.github.io/rcamelspe/reference/read_timeseries.md)
  : Read CAMELS-PE time series
- [`read_geospatial()`](https://pefrens.github.io/rcamelspe/reference/read_geospatial.md)
  : Read CAMELS-PE geospatial data
