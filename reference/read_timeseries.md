# Read CAMELS-PE time series

Compatibility alias matching the `RCamelsPE::read_timeseries()`
interface, powered by the high-performance 'arrow' dataset and
'collapse' query engine.

## Usage

``` r
read_timeseries(
  gauge_id = NULL,
  global = FALSE,
  vars = NULL,
  start_date = NULL,
  end_date = NULL,
  path = get_camels_pe_path()
)
```

## Arguments

- gauge_id:

  Character vector or `NULL`. Gauge identifiers to read.

- global:

  Logical value. If `TRUE`, forces reading from the global file. If
  `FALSE`, reads individual catchment files when available.

- vars:

  Character vector or `NULL`. Optional variable names to retain.

- start_date:

  Optional character string or Date (`"YYYY-MM-DD"`).

- end_date:

  Optional character string or Date (`"YYYY-MM-DD"`).

- path:

  Character string. Optional path to the CAMELS-PE root directory.

## Value

A `data.frame` containing CAMELS-PE time series data.

## Examples

``` r
# Read timeseries using RCamelsPE compatible syntax
ts <- read_timeseries(gauge_id = "PE_110139", vars = c("date", "prec", "flow_obs"))
head(ts)
#>         date  gauge_id  prec flow_obs
#> 1 2000-01-01 PE_110139 5.758       NA
#> 2 2000-01-02 PE_110139 3.417       NA
#> 3 2000-01-03 PE_110139 5.581       NA
#> 4 2000-01-04 PE_110139 5.377       NA
#> 5 2000-01-05 PE_110139 3.782       NA
#> 6 2000-01-06 PE_110139 7.771       NA
```
