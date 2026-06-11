# Helper function to locate the test dataset
find_test_data_path <- function() {
  paths <- c(
    "raw-data/CAMELS-PE",
    "../../raw-data/CAMELS-PE",
    "../../../raw-data/CAMELS-PE",
    "../../../../raw-data/CAMELS-PE",
    "data-raw/CAMELS-PE",
    "../../data-raw/CAMELS-PE",
    "../../../data-raw/CAMELS-PE"
  )
  for (p in paths) {
    if (dir.exists(p)) {
      return(normalizePath(p))
    }
  }
  NULL
}

scrub_path <- function(lines) {
  # Replace absolute/relative path to dummy-path with [path]/dummy-path
  lines <- gsub("does not exist: .*dummy-path", "does not exist: [path]/dummy-path", lines)
  lines
}

test_that("set_camels_pe_path and get_camels_pe_path work", {
  old_path <- getOption("rcamelspe.path")
  on.exit(options(rcamelspe.path = old_path))

  # Test setting path (expecting warning for non-existent path)
  expect_snapshot(set_camels_pe_path("dummy-path"), transform = scrub_path)
  expect_equal(getOption("rcamelspe.path"), normalizePath("dummy-path", mustWork = FALSE))

  # Test setting existing path with missing directories
  temp_dir <- tempfile("camels_test")
  dir.create(temp_dir)
  on.exit(unlink(temp_dir, recursive = TRUE), add = TRUE)
  expect_snapshot(set_camels_pe_path(temp_dir))

  # Attempt to find and set actual test path if available
  path <- find_test_data_path()
  if (!is.null(path)) {
    expect_silent(set_camels_pe_path(path))
    expect_true(dir.exists(get_camels_pe_path()))
  }
})

test_that("load_pe_metadata works", {
  path <- find_test_data_path()
  skip_if(is.null(path), "CAMELS-PE raw data directory not found")
  set_camels_pe_path(path)

  # Load stations
  stations <- load_pe_metadata(type = "stations")
  expect_s3_class(stations, "data.frame")
  expect_true("gauge_id" %in% names(stations))
  expect_true("gauge_name" %in% names(stations))
  expect_equal(nrow(stations), 136)

  # Load dictionary
  dict <- load_pe_metadata(type = "dictionary")
  expect_s3_class(dict, "data.frame")
  expect_true("variable" %in% names(dict))
  expect_true("description" %in% names(dict))

  # Test filtering
  dict_filtered <- load_pe_metadata(type = "dictionary", category = "climatic")
  expect_true(all(dict_filtered$category == "climatic"))

  dict_var <- load_pe_metadata(type = "dictionary", variable = "flow_obs")
  expect_true(all(dict_var$variable == "flow_obs"))

  dict_file <- load_pe_metadata(type = "dictionary", file = "stations.csv")
  expect_true(all(dict_file$file == "stations.csv"))
})

test_that("load_pe_attributes works", {
  path <- find_test_data_path()
  skip_if(is.null(path), "CAMELS-PE raw data directory not found")
  set_camels_pe_path(path)

  # Load specific attribute
  topo <- load_pe_attributes("topographic")
  expect_s3_class(topo, "data.frame")
  expect_true("gauge_id" %in% names(topo))
  expect_true("area" %in% names(topo))

  # Load multiple attributes
  sub_attrs <- load_pe_attributes(c("topographic", "climatic"))
  expect_s3_class(sub_attrs, "data.frame")
  expect_true("area" %in% names(sub_attrs))
  expect_true("p_mean" %in% names(sub_attrs))

  # Load all attributes merged
  all_attrs <- load_pe_attributes("all")
  expect_s3_class(all_attrs, "data.frame")
  expect_true("area" %in% names(all_attrs))
  expect_true("p_mean" %in% names(all_attrs))
  expect_true("soil_dominant_class" %in% names(all_attrs))
  expect_true("forest_perc" %in% names(all_attrs))

  # Test filtering by gauge_ids
  attrs_sub_ids <- load_pe_attributes("topographic", gauge_ids = c("PE_110139", "PE_111151"))
  expect_s3_class(attrs_sub_ids, "data.frame")
  expect_equal(nrow(attrs_sub_ids), 2)
  expect_true(all(attrs_sub_ids$gauge_id %in% c("PE_110139", "PE_111151")))

  # Test category aliases from RCamelsPE
  attrs_hydro <- load_pe_attributes("hydrological")
  expect_s3_class(attrs_hydro, "data.frame")
  expect_true("q_mean" %in% names(attrs_hydro) || "q_mean_obs" %in% names(attrs_hydro))

  attrs_human <- load_pe_attributes("human_intervention")
  expect_s3_class(attrs_human, "data.frame")
})

test_that("load_pe_timeseries works", {
  path <- find_test_data_path()
  skip_if(is.null(path), "CAMELS-PE raw data directory not found")
  set_camels_pe_path(path)

  # 1. Load specific stations (reads from by_catchment)
  ts_sub <- load_pe_timeseries(gauge_ids = c("PE_110139", "PE_111151"))
  expect_s3_class(ts_sub, "data.frame")
  expect_true("date" %in% names(ts_sub))
  expect_true("gauge_id" %in% names(ts_sub))
  expect_true("prec" %in% names(ts_sub))
  expect_s3_class(ts_sub$date, "Date")
  expect_true(all(ts_sub$gauge_id %in% c("PE_110139", "PE_111151")))

  # 2. Test variable subset selection
  ts_vars <- load_pe_timeseries(gauge_ids = "PE_110139", variables = c("prec", "flow_obs"))
  expect_s3_class(ts_vars, "data.frame")
  expect_equal(names(ts_vars), c("date", "gauge_id", "prec", "flow_obs"))

  # 3. Test loading without date parsing
  ts_no_parse <- load_pe_timeseries(gauge_ids = "PE_110139", parse_dates = FALSE)
  expect_false(inherits(ts_no_parse$date, "Date"))

  # 4. Load full dataset (using arrow and collapse filter)
  # Limit columns to minimize memory footprint in tests
  ts_all_prec <- load_pe_timeseries(variables = "prec")
  expect_s3_class(ts_all_prec, "data.frame")
  expect_equal(names(ts_all_prec), c("date", "gauge_id", "prec"))

  # 5. Test robust reading and warnings for missing columns in a dummy file
  temp_dir <- tempfile("camels_test")
  dir.create(temp_dir, recursive = TRUE)
  dir.create(file.path(temp_dir, "03_timeseries"), recursive = TRUE)

  # Create a dummy timeseries.csv file missing 'prec_var'
  dummy_csv <- "date,gauge_id,prec\n1981-01-01,PE_000001,1.5\n"
  writeLines(dummy_csv, file.path(temp_dir, "03_timeseries", "timeseries.csv"))

  # Add other folders to avoid path validation warnings
  dir.create(file.path(temp_dir, "01_metadata"))
  dir.create(file.path(temp_dir, "02_attributes"))
  dir.create(file.path(temp_dir, "04_geospatial"))

  # Set path and load
  suppressWarnings(set_camels_pe_path(temp_dir))

  # When loading global file, we expect a warning about 'prec_var' missing
  expect_snapshot(load_pe_timeseries(variables = c("prec", "prec_var")))
})

test_that("load_pe_geospatial works", {
  path <- find_test_data_path()
  skip_if(is.null(path), "CAMELS-PE raw data directory not found")
  set_camels_pe_path(path)

  # Load gauges points
  gauges <- load_pe_geospatial(type = "gauges")
  expect_s3_class(gauges, "sf")
  expect_true("gauge_id" %in% names(gauges))

  # Load catchments with filtering
  catchments_sub <- load_pe_geospatial(type = "catchments", gauge_ids = c("PE_110139", "PE_111151"))
  expect_s3_class(catchments_sub, "sf")
  expect_equal(nrow(catchments_sub), 2)
  expect_true("gauge_id" %in% names(catchments_sub))
})

test_that("plotting functions work", {
  path <- find_test_data_path()
  skip_if(is.null(path), "CAMELS-PE raw data directory not found")
  set_camels_pe_path(path)

  # Test plot_pe_timeseries
  ts_data <- load_pe_timeseries(gauge_ids = c("PE_110139", "PE_111151"), variables = "prec")
  p1 <- plot_pe_timeseries(ts_data, variable = "prec")
  expect_s3_class(p1, "ggplot")

  # Test plot_pe_catchments
  catchments <- load_pe_geospatial(type = "catchments", gauge_ids = c("PE_110139", "PE_111151"))
  gauges <- load_pe_geospatial(type = "gauges", gauge_ids = c("PE_110139", "PE_111151"))
  p2 <- plot_pe_catchments(catchments, gauges = gauges)
  expect_s3_class(p2, "ggplot")

  # Test plot_pe_attribute_map
  attrs <- load_pe_attributes("topographic", gauge_ids = c("PE_110139", "PE_111151"))
  p3 <- plot_pe_attribute_map(catchments, attrs, variable = "area")
  expect_s3_class(p3, "ggplot")
})
