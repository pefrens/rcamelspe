# Load CAMELS-PE geospatial data

Loads the geospatial catchment boundaries (polygons) or gauging station
locations (points) from the CAMELS-PE dataset.

## Usage

``` r
load_pe_geospatial(
  type = c("catchments", "gauges"),
  gauge_ids = NULL,
  path = get_camels_pe_path()
)
```

## Arguments

- type:

  Character. Either `"catchments"` to load catchment boundary polygons
  or `"gauges"` to load gauge point locations.

- gauge_ids:

  Character vector. Station identifiers to filter the spatial features.
  If `NULL` (default), loads all features.

- path:

  Character. Path to the CAMELS-PE dataset directory. If NULL, retrieved
  via
  [`get_camels_pe_path()`](https://pefrens.github.io/rcamelspe/reference/get_camels_pe_path.md).

## Value

An `sf` spatial object containing the requested geometries.

## Examples

``` r
if (FALSE) { # \dontrun{
# Load all catchment boundaries
catchments <- load_pe_geospatial(type = "catchments")

# Load specific gauging stations
gauges_sub <- load_pe_geospatial(type = "gauges", gauge_ids = c("PE_110139", "PE_111151"))
} # }
```
