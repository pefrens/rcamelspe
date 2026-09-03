# Read CAMELS-PE data dictionary

Reads the CAMELS-PE data dictionary with optional filters by category,
variable, or source file. Compatible with the `RCamelsPE` interface.

## Usage

``` r
read_dictionary(
  category = NULL,
  variable = NULL,
  file = NULL,
  path = get_camels_pe_path()
)
```

## Arguments

- category:

  Character vector or `NULL`. Optional category filter.

- variable:

  Character vector or `NULL`. Optional variable filter.

- file:

  Character vector or `NULL`. Optional file filter.

- path:

  Character string. Optional path to the CAMELS-PE root directory. If
  not provided, retrieved automatically via
  [`get_camels_pe_path()`](https://pefrens.github.io/rcamelspe/reference/get_camels_pe_path.md).

## Value

A `data.frame` containing the CAMELS-PE data dictionary entries.

## Examples

``` r
# Read full dictionary
dict <- read_dictionary()
head(dict)
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

# Read dictionary for topographic category
topo_dict <- read_dictionary(category = "topographic")
head(topo_dict)
#>          folder                       file    category    variable
#> 1 02_attributes topographic_attributes.csv topographic        area
#> 2 02_attributes topographic_attributes.csv topographic   perimeter
#> 3 02_attributes topographic_attributes.csv topographic    elev_min
#> 4 02_attributes topographic_attributes.csv topographic    elev_max
#> 5 02_attributes topographic_attributes.csv topographic   elev_mean
#> 6 02_attributes topographic_attributes.csv topographic elev_median
#>                   description  unit      source
#> 1              Catchment area   km2 FABDEM v1.2
#> 2         Catchment perimeter    km FABDEM v1.2
#> 3 Catchment minimum elevation m_asl FABDEM v1.2
#> 4 Catchment maximum elevation m_asl FABDEM v1.2
#> 5    Catchment mean elevation m_asl FABDEM v1.2
#> 6  Catchment median elevation m_asl FABDEM v1.2
```
