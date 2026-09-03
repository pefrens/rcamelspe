#' Download the CAMELS-PE dataset from Zenodo
#'
#' Downloads the CAMELS-PE dataset zip file from the Zenodo repository
#' (\doi{10.5281/zenodo.20058779}) and extracts it in the destination folder.
#'
#' @param dest_dir Character string. Destination directory where the dataset should be
#'   saved. Defaults to the persistent user data directory
#'   (`tools::R_user_dir("rcamelspe", "data")`).
#' @param unzip Logical. Should the downloaded file be unzipped? Default is `TRUE`.
#' @param overwrite Logical. If destination files already exist, should they be overwritten?
#'   Default is `FALSE`.
#' @param quiet Logical. Should download progress be suppressed? Default is `FALSE`.
#'
#' @return Character string indicating the directory path where the dataset is located
#'   or extracted.
#' @export
#'
#' @examples
#' \dontrun{
#' # Download and unzip to persistent user data folder
#' download_pe_data()
#'
#' # Download to a custom folder
#' download_pe_data(dest_dir = tempdir())
#' }
download_pe_data <- function(dest_dir = tools::R_user_dir("rcamelspe", which = "data"),
                             unzip = TRUE,
                             overwrite = FALSE,
                             quiet = FALSE) {
  url <- "https://zenodo.org/api/records/20058779/files/CAMELS-PE_v1.0.zip/content"

  if (!dir.exists(dest_dir)) {
    dir.create(dest_dir, recursive = TRUE)
  }

  zip_file <- file.path(dest_dir, "CAMELS-PE_v1.0.zip")

  # Download the zip file
  if (!file.exists(zip_file) || overwrite) {
    if (!quiet) {
      cli::cli_inform("Downloading CAMELS-PE dataset from Zenodo...")
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
      cli::cli_inform("Zip file already exists. Use {.code overwrite = TRUE} to download again.")
    }
  }

  # Unzip the file
  if (unzip) {
    expected_dir <- file.path(dest_dir, "CAMELS-PE")
    if (!dir.exists(expected_dir) || overwrite) {
      if (!quiet) {
        cli::cli_inform("Unzipping dataset to {.path {dest_dir}}...")
      }
      utils::unzip(zipfile = zip_file, exdir = dest_dir, overwrite = overwrite)
    } else {
      if (!quiet) {
        cli::cli_inform("Extracted directory already exists. Use {.code overwrite = TRUE} to extract again.")
      }
    }
    pe_dir <- expected_dir
    set_camels_pe_path(pe_dir)
    return(pe_dir)
  }

  set_camels_pe_path(dest_dir)
  return(dest_dir)
}

#' Download CAMELS-PE dataset from Zenodo
#'
#' Compatibility alias matching `RCamelsPE::download_camels_pe()`.
#'
#' @param path Character string. Destination directory where dataset will be stored.
#' @param version Character string. Dataset version. Default is `"1.0"`.
#' @param unzip Logical. Should the downloaded file be extracted? Default is `TRUE`.
#' @param overwrite Logical. If `TRUE`, existing files will be overwritten.
#' @param set_path Logical. If `TRUE`, sets dataset path in session options.
#'
#' @return Character string indicating the path to the downloaded archive or directory.
#' @export
#'
#' @examples
#' \dontrun{
#' download_camels_pe(path = tempdir(), unzip = FALSE)
#' }
download_camels_pe <- function(path,
                               version = "1.0",
                               unzip = TRUE,
                               overwrite = FALSE,
                               set_path = TRUE) {
  if (missing(path) || is.null(path) || length(path) != 1L || is.na(path)) {
    cli::cli_abort("Please provide a valid destination directory through {.arg path}.")
  }

  res <- download_pe_data(
    dest_dir = path,
    unzip = unzip,
    overwrite = overwrite,
    quiet = FALSE
  )

  if (set_path) {
    set_camels_pe_path(res)
  }

  invisible(res)
}
