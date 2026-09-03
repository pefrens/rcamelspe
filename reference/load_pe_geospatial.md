# Load CAMELS-PE geospatial data

Loads geospatial catchment boundary polygons or gauging station point
locations from the CAMELS-PE dataset as `sf` spatial objects.

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

  Character string. Either `"catchments"` to load catchment boundary
  polygons or `"gauges"` to load gauge point locations.

- gauge_ids:

  Character vector. Station identifiers to filter the spatial features.
  If `NULL` (default), loads all spatial features.

- path:

  Character string. Path to the CAMELS-PE dataset directory. If `NULL`,
  retrieved automatically via
  [`get_camels_pe_path()`](https://pefrens.github.io/rcamelspe/reference/get_camels_pe_path.md).

## Value

An `sf` spatial data frame object containing the requested geometries
and station attributes.

## Examples

``` r
# Load all catchment boundaries
catchments <- load_pe_geospatial(type = "catchments")
catchments
#> Simple feature collection with 2 features and 10 fields
#> Geometry type: POLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -76.85792 ymin: -11.76708 xmax: -76.37125 ymax: -10.76458
#> Geodetic CRS:  WGS 84
#>    gauge_id             name       name_cat      area perimeter is_nested
#> 1 PE_110139            Picoy  Cuenca Huaura  360.5843   98.0372      TRUE
#> 2 PE_111151 Puente Magdalena Cuenca Chillón 1263.8044  217.0139      TRUE
#>   downstream_gauge_id upstream_gauge_id nested_group_id nested_group_size
#> 1         PE_4724966C              NONE     PE_4724966C                 2
#> 2           PE_212500       PE_47E9F488       PE_212500                 4
#>                             geom
#> 1 POLYGON ((-76.73042 -10.833...
#> 2 POLYGON ((-76.82125 -11.649...

# Load specific gauging stations
gauges_sub <- load_pe_geospatial(type = "gauges", gauge_ids = "PE_110139")
gauges_sub
#> Simple feature collection with 1 feature and 13 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: -76.858 ymin: -11.696 xmax: -76.736 ymax: -10.922
#> Geodetic CRS:  WGS 84
#>    gauge_id  name latitude longitude   COMID      name_cat     area perimeter
#> 1 PE_110139 Picoy  -10.922   -76.736 9068753 Cuenca Huaura 360.5843   98.0372
#>   is_nested downstream_gauge_id upstream_gauge_id nested_group_id
#> 1      TRUE         PE_4724966C              NONE     PE_4724966C
#>   nested_group_size                    geom
#> 1                 2 POINT (-76.736 -10.922)
```
