#' Load CAMELS-PE geospatial data
#'
#' Loads the geospatial catchment boundaries (polygons) or gauging station locations (points)
#' from the CAMELS-PE dataset.
#'
#' @param type Character. Either `"catchments"` to load catchment boundary polygons
#'   or `"gauges"` to load gauge point locations.
#' @param gauge_ids Character vector. Station identifiers to filter the spatial features.
#'   If `NULL` (default), loads all features.
#' @param path Character. Path to the CAMELS-PE dataset directory. If NULL,
#'   retrieved via [get_camels_pe_path()].
#'
#' @return An `sf` spatial object containing the requested geometries.
#' @export
#'
#' @examples
#' \dontrun{
#' # Load all catchment boundaries
#' catchments <- load_pe_geospatial(type = "catchments")
#'
#' # Load specific gauging stations
#' gauges_sub <- load_pe_geospatial(type = "gauges", gauge_ids = c("PE_110139", "PE_111151"))
#' }
load_pe_geospatial <- function(type = c("catchments", "gauges"), gauge_ids = NULL, path = get_camels_pe_path()) {
  type <- match.arg(type)

  if (is.null(path) || !dir.exists(path)) {
    stop(
      "CAMELS-PE dataset path not found or invalid. Please download the dataset ",
      "using `download_pe_data()` or configure it via `set_camels_pe_path()`."
    )
  }

  file_name <- switch(
    type,
    catchments = "camels_pe_catchments.gpkg",
    gauges = "camels_pe_gauges.gpkg"
  )

  file_path <- file.path(path, "04_geospatial", file_name)

  if (!file.exists(file_path)) {
    stop("Geospatial file not found at: ", file_path)
  }

  sf_obj <- sf::st_read(file_path, quiet = TRUE)

  if (!is.null(gauge_ids)) {
    sf_obj <- collapse::fsubset(sf_obj, gauge_id %in% gauge_ids)
  }

  return(sf_obj)
}
