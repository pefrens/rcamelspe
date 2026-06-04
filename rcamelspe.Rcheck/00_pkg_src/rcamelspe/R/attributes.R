#' Load CAMELS-PE catchment attributes
#'
#' Loads one or more catchment attribute files and merges them by `gauge_id`.
#'
#' @param attributes Character vector. The attributes to load. Can be any combination of
#'   `"topographic"`, `"climatic"`, `"geologic"`, `"soil"`, `"landcover"`, `"intervention"`,
#'   and `"signatures"`, or `"all"` (default) to load and merge all attributes.
#' @param path Character. Path to the CAMELS-PE dataset directory. If NULL,
#'   retrieved via [get_camels_pe_path()].
#'
#' @return A data frame containing the merged attributes.
#' @export
#'
#' @examples
#' \dontrun{
#' # Load all attributes merged
#' attrs_all <- load_pe_attributes()
#'
#' # Load only topographic and climatic attributes
#' attrs_sub <- load_pe_attributes(c("topographic", "climatic"))
#' }
load_pe_attributes <- function(attributes = "all", path = get_camels_pe_path()) {
  if (is.null(path) || !dir.exists(path)) {
    stop(
      "CAMELS-PE dataset path not found or invalid. Please download the dataset ",
      "using `download_pe_data()` or configure it via `set_camels_pe_path()`."
    )
  }

  valid_attrs <- c(
    "topographic", "climatic", "geologic", "soil",
    "landcover", "intervention", "signatures"
  )

  if (length(attributes) == 1 && attributes == "all") {
    selected_attrs <- valid_attrs
  } else {
    selected_attrs <- match.arg(attributes, choices = valid_attrs, several.ok = TRUE)
  }

  # File mapping
  attr_files <- list(
    topographic = "topographic_attributes.csv",
    climatic = "climatic_indices.csv",
    geologic = "geologic_attributes.csv",
    soil = "soil_attributes.csv",
    landcover = "landcover_attributes.csv",
    intervention = "human_intervention_attributes.csv",
    signatures = "hydrological_signatures.csv"
  )

  loaded_dfs <- list()

  for (attr in selected_attrs) {
    file_name <- attr_files[[attr]]
    file_path <- file.path(path, "02_attributes", file_name)

    if (!file.exists(file_path)) {
      warning("Attribute file not found: ", file_path)
      next
    }

    # Load efficiently using arrow
    df <- arrow::read_csv_arrow(file_path)
    df <- as.data.frame(df)

    loaded_dfs[[attr]] <- df
  }

  if (length(loaded_dfs) == 0) {
    return(data.frame())
  }

  # Merge all loaded data frames using collapse::join (fast full outer join)
  merged_df <- loaded_dfs[[1]]

  if (length(loaded_dfs) > 1) {
    for (i in 2:length(loaded_dfs)) {
      merged_df <- collapse::join(
        merged_df,
        loaded_dfs[[i]],
        on = "gauge_id",
        how = "full",
        verbose = FALSE
      )
    }
  }

  return(merged_df)
}
