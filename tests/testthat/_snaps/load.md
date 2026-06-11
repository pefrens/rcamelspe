# set_camels_pe_path and get_camels_pe_path work

    Code
      set_camels_pe_path("dummy-path")
    Condition
      Warning:
      The provided CAMELS-PE path does not exist: [path]/dummy-path

---

    Code
      set_camels_pe_path(temp_dir)
    Condition
      Warning:
      The following required CAMELS-PE folders are missing: 01_metadata, 02_attributes, 03_timeseries, 04_geospatial

# load_pe_timeseries works

    Code
      load_pe_timeseries(variables = c("prec", "prec_var"))
    Condition
      Warning:
      Some columns were not found in the main timeseries file: prec_var
    Output
              date  gauge_id prec
      1 1981-01-01 PE_000001  1.5

