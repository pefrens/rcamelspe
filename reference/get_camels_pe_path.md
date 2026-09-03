# Get the path to the CAMELS-PE dataset

Retrieves the path to the CAMELS-PE dataset directory. It looks up paths
in the following order of precedence:

1.  The package option `rcamelspe.path`.

2.  The environment variable `CAMELS_PE_PATH`.

3.  The persistent user data directory
    (`tools::R_user_dir("rcamelspe", "data")`).

4.  Default search paths in the current working directory
    (`raw-data/CAMELS-PE`, `data-raw/CAMELS-PE`, etc.).

5.  The bundled minimal sample dataset in
    `inst/extdata/sample_camels_pe`.

## Usage

``` r
get_camels_pe_path()

get_camels_path()
```

## Value

Character string containing the directory path where the dataset is
located, or `NULL` if no valid path is found.

## Examples

``` r
camels_path <- get_camels_pe_path()
is.character(camels_path)
#> [1] TRUE
```
