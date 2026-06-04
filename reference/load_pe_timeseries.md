# Load CAMELS-PE daily timeseries data

Efficiently loads the daily hydroclimatic timeseries for Peruvian
catchments. Optimized to load either specific catchments from individual
files or the entire dataset using 'arrow' and 'collapse'.

## Usage

``` r
load_pe_timeseries(
  gauge_ids = NULL,
  variables = NULL,
  path = get_camels_pe_path(),
  parse_dates = TRUE,
  use_arrow = TRUE
)
```

## Arguments

- gauge_ids:

  Character vector. Station/catchment identifiers (e.g. `"PE_110139"`).
  If `NULL` (default), loads timeseries for all 136 catchments.

- variables:

  Character vector. Names of the hydroclimatic variables to select. If
  `NULL` (default), all variables are loaded. Allowed variables:
  `"prec"`, `"prec_var"`, `"flow_obs"`, `"flow_sim"`, `"pet"`, `"tmin"`,
  `"tmean"`, `"tmax"`, `"srad"`, `"vprp"`.

- path:

  Character. Path to the CAMELS-PE dataset directory. If NULL, retrieved
  via
  [`get_camels_pe_path()`](https://pefrens.github.io/rcamelspe/reference/get_camels_pe_path.md).

- parse_dates:

  Logical. Should the `date` column be parsed into R Date objects?
  Default is `TRUE`.

- use_arrow:

  Logical. Should the 'arrow' package be used for reading? Default is
  `TRUE` (recommended for speed).

## Value

A data frame containing the daily timeseries.

## Examples

``` r
if (FALSE) { # \dontrun{
# Load timeseries for a specific station
ts_station <- load_pe_timeseries("PE_110139")

# Load only precipitation and observed streamflow for all stations
ts_sub <- load_pe_timeseries(variables = c("prec", "flow_obs"))
} # }
```
