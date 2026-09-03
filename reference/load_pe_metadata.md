# Load CAMELS-PE metadata

Loads gauging station metadata or the data dictionary from the CAMELS-PE
dataset.

## Usage

``` r
load_pe_metadata(
  type = c("stations", "dictionary"),
  category = NULL,
  variable = NULL,
  file = NULL,
  path = get_camels_pe_path()
)
```

## Arguments

- type:

  Character string. Either `"stations"` to load gauging station metadata
  or `"dictionary"` to load the data dictionary.

- category:

  Character vector or `NULL`. Optional category filter for the
  dictionary (e.g. `"climatic"`).

- variable:

  Character vector or `NULL`. Optional variable filter for the
  dictionary (e.g. `"flow_obs"`).

- file:

  Character vector or `NULL`. Optional file filter for the dictionary
  (e.g. `"stations.csv"`).

- path:

  Character string. Path to the CAMELS-PE dataset directory. If `NULL`,
  retrieved automatically via
  [`get_camels_pe_path()`](https://pefrens.github.io/rcamelspe/reference/get_camels_pe_path.md).

## Value

A `data.frame` containing the requested metadata:

- When `type = "stations"`: station metadata including `gauge_id`,
  `gauge_name`, geographic coordinates, elevation, and hydrologic
  regions.

- When `type = "dictionary"`: dictionary entries with columns `folder`,
  `file`, `category`, `variable`, `description`, `unit`, and `source`.

## Examples

``` r
# Load stations metadata
stations <- load_pe_metadata(type = "stations")
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

# Load data dictionary
data_dict <- load_pe_metadata(type = "dictionary")
head(data_dict)
#>        folder         file category     variable
#> 1 01_metadata stations.csv metadata     gauge_id
#> 2 01_metadata stations.csv metadata   gauge_name
#> 3 01_metadata stations.csv metadata gauge_region
#> 4 01_metadata stations.csv metadata    gauge_lat
#> 5 01_metadata stations.csv metadata    gauge_lon
#> 6 01_metadata stations.csv metadata   gauge_elev
#>                                description  unit  source
#> 1 Catchment identifier provided by SENAMHI     - SENAMHI
#> 2           Gauge name provided by SENAMHI     - SENAMHI
#> 3                      Hydrographic region     - SENAMHI
#> 4                   Gauge latitude (WGS84)  degN SENAMHI
#> 5                  Gauge longitude (WGS84)  degE SENAMHI
#> 6                          Gauge elevation m_asl SENAMHI

# Load data dictionary filtered by category
clim_dict <- load_pe_metadata(type = "dictionary", category = "climatic")
```
