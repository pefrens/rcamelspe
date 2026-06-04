# Load CAMELS-PE catchment attributes

Loads one or more catchment attribute files and merges them by
`gauge_id`.

## Usage

``` r
load_pe_attributes(attributes = "all", path = get_camels_pe_path())
```

## Arguments

- attributes:

  Character vector. The attributes to load. Can be any combination of
  `"topographic"`, `"climatic"`, `"geologic"`, `"soil"`, `"landcover"`,
  `"intervention"`, and `"signatures"`, or `"all"` (default) to load and
  merge all attributes.

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
} # }
```
