# Load CAMELS-PE catchment attributes

Loads one or more catchment attribute files and merges them by
`gauge_id`.

## Usage

``` r
load_pe_attributes(
  attributes = "all",
  gauge_ids = NULL,
  path = get_camels_pe_path()
)
```

## Arguments

- attributes:

  Character vector. The attributes to load. Can be any combination of
  `"topographic"`, `"climatic"`, `"geologic"`, `"soil"`, `"landcover"`,
  `"intervention"`, and `"signatures"`, or `"all"` (default) to load and
  merge all attributes. Aliases `"hydrological"` (for `"signatures"`)
  and `"human_intervention"` (for `"intervention"`) are also supported.

- gauge_ids:

  Character vector. Optional gauge identifiers to filter the returned
  attributes. If `NULL`, attributes for all catchments are returned.

- path:

  Character. Path to the CAMELS-PE dataset directory. If NULL, retrieved
  via
  [`get_camels_pe_path()`](https://pefrens.github.io/rcamelspe/reference/get_camels_pe_path.md).

## Value

A data frame containing the merged attributes.

## Examples

``` r
if (FALSE) { # \dontrun{
# Load all attributes merged
attrs_all <- load_pe_attributes()

# Load only topographic and climatic attributes
attrs_sub <- load_pe_attributes(c("topographic", "climatic"))

# Load attributes for specific stations
attrs_sel <- load_pe_attributes(gauge_ids = c("PE_212900", "PE_200907"))
} # }
```
