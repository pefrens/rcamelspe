#' Load CAMELS-PE metadata
#'
#' Loads the gauging station metadata or the data dictionary from the CAMELS-PE dataset.
#'
#' @param type Character. Either `"stations"` to load the gauging station metadata
#'   or `"dictionary"` to load the data dictionary.
#' @param category Character vector or `NULL`. Optional category filter for the dictionary (e.g. `"climatic"`).
#' @param variable Character vector or `NULL`. Optional variable filter for the dictionary (e.g. `"flow_obs"`).
#' @param file Character vector or `NULL`. Optional file filter for the dictionary (e.g. `"stations.csv"`).
#' @param path Character. Path to the CAMELS-PE dataset directory. If NULL,
#'   retrieved via [get_camels_pe_path()].
#'
#' @return A data frame (tibble-like) containing the requested metadata.
#' @export
#'
#' @examples
#' \dontrun{
#' # Load stations metadata
#' stations <- load_pe_metadata(type = "stations")
#'
#' # Load data dictionary
#' data_dict <- load_pe_metadata(type = "dictionary")
#'
#' # Load data dictionary filtered by category
#' climatic_dict <- load_pe_metadata(type = "dictionary", category = "climatic")
#' }
load_pe_metadata <- function(type = c("stations", "dictionary"),
                             category = NULL,
                             variable = NULL,
                             file = NULL,
                             path = get_camels_pe_path()) {
  type <- match.arg(type)

  if (is.null(path) || !dir.exists(path)) {
    stop(
      "CAMELS-PE dataset path not found or invalid. Please download the dataset ",
      "using `download_pe_data()` or configure it via `set_camels_pe_path()`."
    )
  }

  file_name <- switch(
    type,
    stations = "stations.csv",
    dictionary = "data_dictionary.csv"
  )

  file_path <- file.path(path, "01_metadata", file_name)

  if (!file.exists(file_path)) {
    stop("Metadata file not found at: ", file_path)
  }

  # Load efficiently using arrow
  df <- arrow::read_csv_arrow(file_path)
  df <- as.data.frame(df)

  if (type == "dictionary") {
    required_cols <- c(
      "folder",
      "file",
      "category",
      "variable",
      "description",
      "unit",
      "source"
    )

    missing_cols <- setdiff(required_cols, names(df))

    if (length(missing_cols) > 0) {
      stop(
        "The dictionary file is missing required columns: ",
        paste(missing_cols, collapse = ", "),
        call. = FALSE
      )
    }

    if (!is.null(category)) {
      cat_filter <- category
      df <- collapse::fsubset(df, category %in% cat_filter)
    }

    if (!is.null(variable)) {
      var_filter <- variable
      df <- collapse::fsubset(df, variable %in% var_filter)
    }

    if (!is.null(file)) {
      file_filter <- file
      df <- collapse::fsubset(df, file %in% file_filter)
    }
  }

  return(df)
}
