# Download the CAMELS-PE dataset from Zenodo

Downloads the CAMELS-PE dataset zip file from the Zenodo repository and
optionally unzips it in the destination folder.

## Usage

``` r
download_pe_data(
  dest_dir = "data-raw",
  unzip = TRUE,
  overwrite = FALSE,
  quiet = FALSE
)
```

## Arguments

- dest_dir:

  Character. Destination directory where the dataset should be saved.
  Defaults to "data-raw".

- unzip:

  Logical. Should the downloaded file be unzipped? Default is `TRUE`.

- overwrite:

  Logical. If the destination files already exist, should they be
  overwritten? Default is `FALSE`.

- quiet:

  Logical. Should download progress be suppressed? Default is `FALSE`.

## Value

Character. The directory path where the dataset is located or extracted.

## Examples

``` r
if (FALSE) { # \dontrun{
# Download and unzip to a local folder
download_pe_data(dest_dir = "data-raw")
} # }
```
