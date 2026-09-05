# Download the CAMELS-PE dataset from Zenodo

Downloads the CAMELS-PE dataset zip file from the Zenodo repository
([doi:10.5281/zenodo.21195425](https://doi.org/10.5281/zenodo.21195425)
) and extracts it in the destination folder.

## Usage

``` r
download_pe_data(
  dest_dir = tools::R_user_dir("rcamelspe", which = "data"),
  unzip = TRUE,
  overwrite = FALSE,
  quiet = FALSE,
  version = "1.0.1",
  set_path = TRUE
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

- version:

  Character string. Dataset release: `"1.0.1"` (default) or `"1.0"`.

- set_path:

  Logical. Configure the session path after extraction only.

## Value

Character string indicating the directory path where the dataset is
located or extracted; the ZIP path when `unzip = FALSE`. Use a separate
destination for each release, or `overwrite = TRUE` to replace an
existing extraction.

## Examples

``` r
if (FALSE) { # \dontrun{
# Download and unzip to persistent user data folder
download_pe_data()

# Download to a custom folder
download_pe_data(dest_dir = tempdir())
} # }
```
