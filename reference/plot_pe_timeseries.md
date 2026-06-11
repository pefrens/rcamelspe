# Plot CAMELS-PE Time Series

Creates a time series plot for one CAMELS-PE variable, such as
precipitation, observed streamflow, simulated streamflow, or
temperature. The function returns a `ggplot` object, so it can be
further customized using standard `ggplot2` layers.

## Usage

``` r
plot_pe_timeseries(
  data,
  variable = "flow_obs",
  gauge_id = NULL,
  date_col = "date",
  facet = TRUE,
  scales = "free_y",
  ...
)
```

## Arguments

- data:

  A data frame containing CAMELS-PE time series.

- variable:

  Character string. Name of the variable to plot. Default is
  `"flow_obs"`.

- gauge_id:

  Optional character vector. Gauge IDs used to filter the data before
  plotting. If `NULL`, all available gauges are plotted.

- date_col:

  Character string. Name of the date column. Default is `"date"`.

- facet:

  Logical value. If `TRUE` (default), creates one panel per gauge ID.

- scales:

  Character string. Scales passed to
  [`ggplot2::facet_wrap()`](https://ggplot2.tidyverse.org/reference/facet_wrap.html).
  One of `"fixed"`, `"free"`, `"free_x"`, or `"free_y"` (default).

- ...:

  Additional arguments passed to
  [`ggplot2::geom_line()`](https://ggplot2.tidyverse.org/reference/geom_path.html).

## Value

A `ggplot` object.

## Examples

``` r
if (FALSE) { # \dontrun{
ts <- load_pe_timeseries(
  gauge_ids = c("PE_212900", "PE_200907"),
  variables = c("prec", "flow_obs")
)
plot_pe_timeseries(ts, variable = "flow_obs")
} # }
```
