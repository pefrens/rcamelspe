#' Load CAMELS-PE daily timeseries data
#'
#' Efficiently loads the daily hydroclimatic timeseries for Peruvian catchments.
#' Optimized to load either specific catchments from individual files or the entire
#' dataset using 'arrow' and 'collapse'.
#'
#' @param gauge_ids Character vector. Station/catchment identifiers (e.g. `"PE_110139"`).
#'   If `NULL` (default), loads timeseries for all 136 catchments.
#' @param variables Character vector. Names of the hydroclimatic variables to select.
#'   If `NULL` (default), all variables are loaded. Allowed variables:
#'   `"prec"`, `"prec_var"`, `"flow_obs"`, `"flow_sim"`, `"pet"`, `"tmin"`,
#'   `"tmean"`, `"tmax"`, `"srad"`, `"vprp"`.
#' @param path Character. Path to the CAMELS-PE dataset directory. If NULL,
#'   retrieved via [get_camels_pe_path()].
#' @param parse_dates Logical. Should the `date` column be parsed into R Date objects?
#'   Default is `TRUE`.
#' @param use_arrow Logical. Should the 'arrow' package be used for reading?
#'   Default is `TRUE` (recommended for speed).
#'
#' @return A data frame containing the daily timeseries.
#' @export
#'
#' @examples
#' \dontrun{
#' # Load timeseries for a specific station
#' ts_station <- load_pe_timeseries("PE_110139")
#'
#' # Load only precipitation and observed streamflow for all stations
#' ts_sub <- load_pe_timeseries(variables = c("prec", "flow_obs"))
#' }
load_pe_timeseries <- function(gauge_ids = NULL, variables = NULL, path = get_camels_pe_path(),
                               parse_dates = TRUE, use_arrow = TRUE) {
  if (is.null(path) || !dir.exists(path)) {
    cli::cli_abort(c(
      "CAMELS-PE dataset path not found or invalid.",
      "i" = "Please download the dataset using {.fn download_pe_data} or configure it via {.fn set_camels_pe_path}."
    ))
  }

  valid_vars <- c(
    "prec", "prec_var", "flow_obs", "flow_sim", "pet",
    "tmin", "tmean", "tmax", "srad", "vprp"
  )

  if (!is.null(variables)) {
    variables <- match.arg(variables, choices = valid_vars, several.ok = TRUE)
  }

  # Columns to keep (always keep date and gauge_id)
  keep_cols <- c("date", "gauge_id")
  if (!is.null(variables)) {
    keep_cols <- c(keep_cols, variables)
  }

  # Strategy decision: if requesting a few gauge_ids, read from by_catchment
  # Threshold = 10 stations
  read_by_catchment <- !is.null(gauge_ids) && length(gauge_ids) <= 10

  if (read_by_catchment) {
    catchment_dir <- file.path(path, "03_timeseries", "by_catchment")
    if (!dir.exists(catchment_dir)) {
      read_by_catchment <- FALSE  # fallback to main file if folder doesn't exist
    }
  }

  if (read_by_catchment) {
    loaded_dfs <- list()

    for (gid in gauge_ids) {
      file_path <- file.path(catchment_dir, paste0(gid, ".csv"))
      if (!file.exists(file_path)) {
        cli::cli_warn("Timeseries file not found for station {.val {gid}} at {.path {file_path}}")
        next
      }

      # Read individual file
      if (use_arrow) {
        df <- arrow::read_csv_arrow(file_path)
        df <- as.data.frame(df)
      } else {
        df <- utils::read.csv(file_path, stringsAsFactors = FALSE)
      }

      # Add gauge_id and align column ordering
      df$gauge_id <- gid
      col_names <- names(df)
      col_order <- c("date", "gauge_id", setdiff(col_names, c("date", "gauge_id")))
      df <- df[, col_order, drop = FALSE]

      # Filter columns if variables specified
      if (!is.null(variables)) {
        missing_vars <- setdiff(keep_cols, names(df))
        if (length(missing_vars) > 0) {
          cli::cli_warn(c(
            "Some columns were not found in the timeseries file for station {.val {gid}}:",
            "x" = "Missing column{?s}: {.field {missing_vars}}"
          ))
        }
        df <- df[, intersect(names(df), keep_cols), drop = FALSE]
      }

      loaded_dfs[[gid]] <- df
    }

    if (length(loaded_dfs) == 0) {
      return(data.frame())
    }

    # Bind rows quickly using collapse
    res_df <- collapse::rowbind(loaded_dfs)

  } else {
    # Read the main timeseries.csv file
    main_file <- file.path(path, "03_timeseries", "timeseries.csv")
    if (!file.exists(main_file)) {
      cli::cli_abort("Main timeseries file not found at: {.path {main_file}}")
    }

    if (use_arrow) {
      # Use arrow to read and select columns directly to save memory
      if (!is.null(variables)) {
        df <- arrow::read_csv_arrow(main_file, col_select = tidyselect::any_of(keep_cols))
        df <- as.data.frame(df)
        missing_vars <- setdiff(keep_cols, names(df))
        if (length(missing_vars) > 0) {
          cli::cli_warn(c(
            "Some columns were not found in the main timeseries file:",
            "x" = "Missing column{?s}: {.field {missing_vars}}"
          ))
        }
      } else {
        df <- arrow::read_csv_arrow(main_file)
        df <- as.data.frame(df)
      }
    } else {
      df <- utils::read.csv(main_file, stringsAsFactors = FALSE)
      if (!is.null(variables)) {
        missing_vars <- setdiff(keep_cols, names(df))
        if (length(missing_vars) > 0) {
          cli::cli_warn(c(
            "Some columns were not found in the main timeseries file:",
            "x" = "Missing column{?s}: {.field {missing_vars}}"
          ))
        }
        df <- df[, intersect(names(df), keep_cols), drop = FALSE]
      }
    }

    # Filter by gauge_ids using collapse::fsubset for speed
    if (!is.null(gauge_ids)) {
      res_df <- collapse::fsubset(df, gauge_id %in% gauge_ids)
    } else {
      res_df <- df
    }
  }

  # Parse Date objects if requested, or convert back to character if parse_dates = FALSE
  if ("date" %in% names(res_df)) {
    if (parse_dates) {
      if (!inherits(res_df$date, "Date")) {
        res_df$date <- as.Date(res_df$date)
      }
    } else {
      if (inherits(res_df$date, "Date") || inherits(res_df$date, "POSIXt")) {
        res_df$date <- as.character(res_df$date)
      }
    }
  }

  return(res_df)
}
