# Download CAMELS-PE dataset from Zenodo

Compatibility alias matching `RCamelsPE::download_camels_pe()`.

## Usage

``` r
download_camels_pe(
  path,
  version = "1.0.1",
  unzip = TRUE,
  overwrite = FALSE,
  set_path = TRUE
)
```

## Arguments

- path:

  Character string. Destination directory where dataset will be stored.

- version:

  Character string. Dataset release: `"1.0.1"` (default) or `"1.0"`.

- unzip:

  Logical. Should the downloaded file be extracted? Default is `TRUE`.

- overwrite:

  Logical. If `TRUE`, existing files will be overwritten.

- set_path:

  Logical. If `TRUE`, sets dataset path in session options.

## Value

Character string indicating the path to the downloaded archive or
directory.

## Examples

``` r
if (FALSE) { # \dontrun{
download_camels_pe(path = tempdir(), unzip = FALSE)
} # }
```
