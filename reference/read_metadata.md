# Read CAMELS-PE station metadata

Convenience alias for `load_pe_metadata(type = "stations")`, compatible
with the `RCamelsPE` interface.

## Usage

``` r
read_metadata(path = get_camels_pe_path())
```

## Arguments

- path:

  Character string. Optional path to the CAMELS-PE root directory. If
  not provided, retrieved automatically via
  [`get_camels_pe_path()`](https://pefrens.github.io/rcamelspe/reference/get_camels_pe_path.md).

## Value

A `data.frame` containing gauging station metadata.

## Examples

``` r
stations <- read_metadata()
head(stations)
#>    gauge_id       gauge_name gauge_region gauge_lat gauge_lon gauge_elev
#> 1 PE_110139            Picoy      Pacific   -10.922   -76.736       3037
#> 2 PE_111151 Puente Magdalena      Pacific   -11.696   -76.858        872
#>   gauge_record_start gauge_record_end gauge_perc_obs       name_cat is_nested
#> 1         2021-09-01       2025-12-31           9.63  Cuenca Huaura      TRUE
#> 2         1981-01-01       2025-12-31          56.52 Cuenca Chillón      TRUE
#>   nested_group_id nested_group_size downstream_gauge_id upstream_gauge_id
#> 1     PE_4724966C                 2         PE_4724966C              NONE
#> 2       PE_212500                 4           PE_212500       PE_47E9F488
```
