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

test_that("set_camels_pe_path and get_camels_pe_path work", {
  old_path <- getOption("rcamelspe.path")
  on.exit(options(rcamelspe.path = old_path))

  # Test setting path
  set_camels_pe_path("dummy-path")
  expect_equal(getOption("rcamelspe.path"), normalizePath("dummy-path", mustWork = FALSE))

  # Attempt to find and set actual test path if available
  path <- find_test_data_path()
  if (!is.null(path)) {
    set_camels_pe_path(path)
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
