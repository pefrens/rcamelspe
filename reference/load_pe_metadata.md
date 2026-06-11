# Load CAMELS-PE metadata

Loads the gauging station metadata or the data dictionary from the
CAMELS-PE dataset.

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

  Character. Either `"stations"` to load the gauging station metadata or
  `"dictionary"` to load the data dictionary.

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

  Character. Path to the CAMELS-PE dataset directory. If NULL, retrieved
  via
  [`get_camels_pe_path()`](https://pefrens.github.io/rcamelspe/reference/get_camels_pe_path.md).

## Value

A data frame (tibble-like) containing the requested metadata.

## Examples

``` r
if (FALSE) { # \dontrun{
# Load stations metadata
stations <- load_pe_metadata(type = "stations")

# Load data dictionary
data_dict <- load_pe_metadata(type = "dictionary")

# Load data dictionary filtered by category
climatic_dict <- load_pe_metadata(type = "dictionary", category = "climatic")
} # }
```
