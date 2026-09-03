# Read CAMELS-PE geospatial data

Compatibility alias matching `RCamelsPE::read_geospatial()`.

## Usage

``` r
read_geospatial(type = c("gauges", "catchments"), path = get_camels_pe_path())
```

## Arguments

- type:

  Character string. Either `"gauges"` or `"catchments"`.

- path:

  Character string. Optional path to the CAMELS-PE root directory.

## Value

An `sf` spatial object.

## Examples

``` r
catchments <- read_geospatial(type = "catchments")
head(catchments)
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
```
