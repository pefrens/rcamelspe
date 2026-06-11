# Plot CAMELS-PE Attribute Map

Creates a thematic map of CAMELS-PE catchments using a selected
attribute. The function joins attribute data with catchment geometries
by `gauge_id` using
[`collapse::join`](https://fastverse.org/collapse/reference/join.html)
and returns a `ggplot` object.

## Usage

``` r
plot_pe_attribute_map(
  catchments,
  attributes,
  variable,
  gauges = NULL,
  na_color = "grey80",
  ...
)
```

## Arguments

- catchments:

  An `sf` object with catchment polygons.

- attributes:

  A data frame containing CAMELS-PE attributes.

- variable:

  Character string. Name of the attribute to visualize.

- gauges:

  Optional `sf` object with gauge point locations.

- na_color:

  Character string. Color for missing values. Default is `"grey80"`.

- ...:

  Additional arguments passed to
  [`ggplot2::geom_sf()`](https://ggplot2.tidyverse.org/reference/ggsf.html)
  for catchments.

## Value

A `ggplot` object.

## Examples

``` r
if (FALSE) { # \dontrun{
catchments <- load_pe_geospatial(type = "catchments")
attrs <- load_pe_attributes(attributes = "topographic")
plot_pe_attribute_map(catchments, attrs, variable = "area")
} # }
```
