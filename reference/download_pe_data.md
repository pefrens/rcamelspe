# Download the CAMELS-PE dataset from Zenodo

Downloads the CAMELS-PE dataset zip file from the Zenodo repository
([doi:10.5281/zenodo.20058779](https://doi.org/10.5281/zenodo.20058779)
) and extracts it in the destination folder.

## Usage

``` r
download_pe_data(
  dest_dir = tools::R_user_dir("rcamelspe", which = "data"),
  unzip = TRUE,
  overwrite = FALSE,
  quiet = FALSE
)
```

## Arguments

- dest_dir:

  Character string. Destination directory where the dataset should be
  saved. Defaults to the persistent user data directory
  (`tools::R_user_dir("rcamelspe", "data")`).

- unzip:

  Logical. Should the downloaded file be unzipped? Default is `TRUE`.

- overwrite:

  Logical. If destination files already exist, should they be
  overwritten? Default is `FALSE`.

- quiet:

  Logical. Should download progress be suppressed? Default is `FALSE`.

## Value

Character string indicating the directory path where the dataset is
located or extracted.

## Examples

``` r
if (FALSE) { # \dontrun{
# Download and unzip to persistent user data folder
download_pe_data()

# Download to a custom folder
download_pe_data(dest_dir = tempdir())
} # }
```
