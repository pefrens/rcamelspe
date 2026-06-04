#' Download the CAMELS-PE dataset from Zenodo
#'
#' Downloads the CAMELS-PE dataset zip file from the Zenodo repository
#' and optionally unzips it in the destination folder.
#'
#' @param dest_dir Character. Destination directory where the dataset should be saved.
#'   Defaults to "data-raw".
#' @param unzip Logical. Should the downloaded file be unzipped? Default is `TRUE`.
#' @param overwrite Logical. If the destination files already exist, should they be overwritten?
#'   Default is `FALSE`.
#' @param quiet Logical. Should download progress be suppressed? Default is `FALSE`.
#'
#' @return Character. The directory path where the dataset is located or extracted.
#' @export
#'
#' @examples
#' \dontrun{
#' # Download and unzip to a local folder
#' download_pe_data(dest_dir = "data-raw")
#' }
download_pe_data <- function(dest_dir = "data-raw", unzip = TRUE, overwrite = FALSE, quiet = FALSE) {
  url <- "https://zenodo.org/api/records/20058779/files/CAMELS-PE_v1.0.zip/content"

  if (!dir.exists(dest_dir)) {
    dir.create(dest_dir, recursive = TRUE)
  }

  zip_file <- file.path(dest_dir, "CAMELS-PE_v1.0.zip")

  # Download the zip file
  if (!file.exists(zip_file) || overwrite) {
    if (!quiet) {
      message("Downloading CAMELS-PE dataset from Zenodo...")
    }
    # Set timeout to a high number to avoid timeouts with large files
    old_timeout <- getOption("timeout")
    on.exit(options(timeout = old_timeout), add = TRUE)
    options(timeout = max(3600, old_timeout))

    utils::download.file(
      url = url,
      destfile = zip_file,
      mode = "wb",
      quiet = quiet
    )
  } else {
    if (!quiet) {
      message("Zip file already exists. Use overwrite = TRUE to download again.")
    }
  }

  # Unzip the file
  if (unzip) {
    expected_dir <- file.path(dest_dir, "CAMELS-PE")
    if (!dir.exists(expected_dir) || overwrite) {
      if (!quiet) {
        message("Unzipping dataset to ", dest_dir, "...")
      }
      utils::unzip(zipfile = zip_file, exdir = dest_dir, overwrite = overwrite)
    } else {
      if (!quiet) {
        message("Extracted directory already exists. Use overwrite = TRUE to extract again.")
      }
    }
    pe_dir <- expected_dir
    set_camels_pe_path(pe_dir)
    return(pe_dir)
  }

  set_camels_pe_path(dest_dir)
  return(dest_dir)
}
