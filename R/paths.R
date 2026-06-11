#' Set the path to the CAMELS-PE dataset
#'
#' Sets the path to the directory containing the CAMELS-PE dataset.
#' The path is stored in the package options.
#'
#' @param path Character. Path to the CAMELS-PE dataset directory.
#'
#' @return Invisible NULL.
#' @export
#'
#' @examples
#' set_camels_pe_path("data-raw/CAMELS-PE")
set_camels_pe_path <- function(path) {
  if (!is.null(path)) {
    path <- normalizePath(path, mustWork = FALSE)
    if (!dir.exists(path)) {
      warning("The provided CAMELS-PE path does not exist: ", path, call. = FALSE)
    } else {
      required_dirs <- c(
        "01_metadata",
        "02_attributes",
        "03_timeseries",
        "04_geospatial"
      )
      missing_dirs <- required_dirs[!dir.exists(file.path(path, required_dirs))]
      if (length(missing_dirs) > 0) {
        warning(
          "The following required CAMELS-PE folders are missing: ",
          paste(missing_dirs, collapse = ", "),
          call. = FALSE
        )
      }
    }
  }
  options(rcamelspe.path = path)
  invisible(NULL)
}

#' Get the path to the CAMELS-PE dataset
#'
#' Retrieves the path to the CAMELS-PE dataset. It looks up:
#' 1. The package option `rcamelspe.path`.
#' 2. The environment variable `CAMELS_PE_PATH`.
#' 3. The persistent user data directory (`tools::R_user_dir("rcamelspe", "data")`).
#' 4. Default search paths in the current working directory (`raw-data/CAMELS-PE`,
#'    `data-raw/camels-pe`, etc.).
#'
#' @return Character path or `NULL` if not found.
#' @export
#'
#' @examples
#' get_camels_pe_path()
get_camels_pe_path <- function() {
  # 1. Option
  path <- getOption("rcamelspe.path")
  if (!is.null(path) && dir.exists(path)) {
    return(path)
  }

  # 2. Env var
  env_path <- Sys.getenv("CAMELS_PE_PATH")
  if (nzchar(env_path) && dir.exists(env_path)) {
    return(normalizePath(env_path))
  }

  # 3. Persistent user data directory
  user_dir <- tryCatch(
    file.path(tools::R_user_dir("rcamelspe", which = "data"), "CAMELS-PE"),
    error = function(e) NULL
  )
  if (!is.null(user_dir) && dir.exists(user_dir)) {
    return(normalizePath(user_dir))
  }

  # 4. Default workspace checks
  defaults <- c(
    "raw-data/CAMELS-PE",
    "data-raw/CAMELS-PE",
    "raw-data/camels-pe",
    "data-raw/camels-pe",
    "CAMELS-PE"
  )

  for (d in defaults) {
    if (dir.exists(d)) {
      return(normalizePath(d))
    }
  }

  NULL
}
