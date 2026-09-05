# Load CAMELS-PE daily timeseries data

Efficiently loads daily hydroclimatic timeseries for Peruvian
catchments. Features an optimized dual-pathway execution engine using
'arrow' and 'collapse':

- For selective requests, reads individual catchment files with column
  projection.

- For global or multi-catchment requests, uses
  [`arrow::open_dataset()`](https://arrow.apache.org/docs/r/reference/open_dataset.html)
  with predicate pushdown (filtering stations and date ranges directly
  at scan time) to minimize memory footprint and maximize throughput.

## Usage

``` r
load_pe_timeseries(
  gauge_ids = NULL,
  variables = NULL,
  start_date = NULL,
  end_date = NULL,
  path = get_camels_pe_path(),
  parse_dates = TRUE,
  use_arrow = TRUE,
  global = FALSE
)
```

## Arguments

- gauge_ids:

  Character vector. Station/catchment identifiers (e.g. `"PE_110139"`).
  If `NULL` (default), loads timeseries for all available catchments.

- variables:

  Character vector. Names of hydroclimatic variables to select. If
  `NULL` (default), all variables are loaded. Allowed variables:
  `"prec"`, `"prec_var"`, `"flow_obs"`, `"flow_sim"`, `"pet"`, `"tmin"`,
  `"tmean"`, `"tmax"`, `"srad"`, `"vprp"`.

- start_date:

  Optional character string or Date object (`"YYYY-MM-DD"`). Start date
  for temporal filtering.

- end_date:

  Optional character string or Date object (`"YYYY-MM-DD"`). End date
  for temporal filtering.

- path:

  Character string. Path to the CAMELS-PE dataset directory. If `NULL`,
  retrieved automatically via
  [`get_camels_pe_path()`](https://pefrens.github.io/rcamelspe/reference/get_camels_pe_path.md).

- parse_dates:

  Logical. Should the `date` column be parsed into R Date objects?
  Default is `TRUE`.

- use_arrow:

  Logical. Should the 'arrow' package be used for reading? Default is
  `TRUE` (recommended for high performance).

- global:

  Logical. If `TRUE`, read the master CSV even for a small selection.

## Value

A `data.frame` containing daily hydroclimatic timeseries data with at
least `date` and `gauge_id` columns, plus the requested
hydrometeorological variables.

## Details

The common calendar is 1981-2025; unavailable observations remain `NA`.
Streamflow is expressed in mm/day, precipitation variance (`prec_var`)
in mm^2/day^2, solar radiation in MJ/m^2/day, and vapor pressure in hPa.
Identifier columns `date` and `gauge_id` may also be requested in
`variables`. Automatic routing compares selected CSV bytes plus a 4 MiB
per-file opening cost estimate against the master CSV size. This
heuristic avoids scanning the national file for small subsets while
retaining it for large requests. Missing individual files fall back to
the master when it is available. `global = TRUE` always forces the
master. No data cache is created.

## Examples

``` r
# Load timeseries for a specific station
ts_station <- load_pe_timeseries(gauge_ids = "PE_110139")
head(ts_station)
#>         date  gauge_id  prec prec_var flow_obs flow_sim   pet  tmin tmean
#> 1 2000-01-01 PE_110139 5.758    1.290       NA    1.104 2.402 3.856 8.924
#> 2 2000-01-02 PE_110139 3.417    1.512       NA    1.174 2.482 4.149 8.883
#> 3 2000-01-03 PE_110139 5.581    2.679       NA    1.189 2.647 2.964 8.564
#> 4 2000-01-04 PE_110139 5.377    3.625       NA    1.210 2.927 3.351 8.839
#> 5 2000-01-05 PE_110139 3.782    1.403       NA    1.213 2.297 3.484 7.710
#> 6 2000-01-06 PE_110139 7.771    2.605       NA    1.244 2.222 2.464 6.655
#>     tmax   srad  vprp
#> 1 13.993 19.608 7.317
#> 2 13.617 17.539 6.768
#> 3 14.164 19.482 6.235
#> 4 14.327 13.932 7.138
#> 5 11.936 11.778 6.425
#> 6 10.845 14.172 5.711

# Load only precipitation and observed streamflow with date range filter
ts_sub <- load_pe_timeseries(
  gauge_ids = "PE_110139",
  variables = c("prec", "flow_obs"),
  start_date = "2000-01-01",
  end_date = "2000-03-31"
)
head(ts_sub)
#>         date  gauge_id  prec flow_obs
#> 1 2000-01-01 PE_110139 5.758       NA
#> 2 2000-01-02 PE_110139 3.417       NA
#> 3 2000-01-03 PE_110139 5.581       NA
#> 4 2000-01-04 PE_110139 5.377       NA
#> 5 2000-01-05 PE_110139 3.782       NA
#> 6 2000-01-06 PE_110139 7.771       NA
```
