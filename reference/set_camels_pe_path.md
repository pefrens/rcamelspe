# Set the path to the CAMELS-PE dataset

Sets the path to the directory containing the CAMELS-PE dataset. The
path is stored in the package session options.

## Usage

``` r
set_camels_pe_path(path)

set_camels_path(path)
```

## Arguments

- path:

  Character string. Path to the CAMELS-PE dataset directory.

## Value

Invisible `NULL`. Called for its side effect of setting the dataset
path.

## Examples

``` r
sample_path <- system.file("extdata", "sample_camels_pe", package = "rcamelspe")
set_camels_pe_path(sample_path)
```
