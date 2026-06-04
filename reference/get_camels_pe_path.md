# Get the path to the CAMELS-PE dataset

Retrieves the path to the CAMELS-PE dataset. It looks up:

1.  The package option `rcamelspe.path`.

2.  The environment variable `CAMELS_PE_PATH`.

3.  Default search paths in the current working directory
    (`raw-data/CAMELS-PE`, `data-raw/camels-pe`, etc.).

## Usage

``` r
get_camels_pe_path()
```

## Value

Character path or `NULL` if not found.

## Examples

``` r
get_camels_pe_path()
#> NULL
```
