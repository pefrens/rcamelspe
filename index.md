# rcamelspe

The goal of `rcamelspe` is to provide an ultra-fast, computationally
efficient, and user-friendly R interface to download, load, filter, and
manage the **CAMELS-PE** (Catchment Attributes and Meteorology for
Large-sample Studies - Peru) dataset.

CAMELS-PE includes daily meteorological and hydrological time series,
static catchment attributes, and geospatial representations for **136
catchments** distributed across the Pacific, Atlantic, and Titicaca
hydrographic regions of Peru.

To handle large volumes of records (over 2.2 million rows of daily
climate observations and simulations) with maximum speed and minimum
memory footprint, the package is engineered using: - **`arrow`**: for
memory-mapped dataset reading, predicate pushdown (filtering stations
and dates directly at the C++ scan level), and zero-overhead column
projection. - **`collapse`**: for fast C/C++ data frame transformations,
grouped calculations, row binding, and relational joins. - **`RCamelsPE`
compatibility**: full drop-in compatibility and aliases
([`read_timeseries()`](https://pefrens.github.io/rcamelspe/reference/read_timeseries.md),
[`read_attributes()`](https://pefrens.github.io/rcamelspe/reference/read_attributes.md),
[`read_metadata()`](https://pefrens.github.io/rcamelspe/reference/read_metadata.md),
[`read_dictionary()`](https://pefrens.github.io/rcamelspe/reference/read_dictionary.md),
[`read_geospatial()`](https://pefrens.github.io/rcamelspe/reference/read_geospatial.md),
[`set_camels_path()`](https://pefrens.github.io/rcamelspe/reference/set_camels_pe_path.md),
[`get_camels_path()`](https://pefrens.github.io/rcamelspe/reference/get_camels_pe_path.md)).

------------------------------------------------------------------------

## Installation

You can install the released version of `rcamelspe` from CRAN with:

``` r

install.packages("rcamelspe")
```

And the development version from GitHub with:

``` r

# install.packages("pak")
pak::pak("pefrens/rcamelspe")
```

------------------------------------------------------------------------

## Bundled Sample Dataset & Instant Exploration

`rcamelspe` includes a lightweight, self-contained sample dataset in
`inst/extdata/sample_camels_pe` (~120 KB) covering 2 representative
catchments (`PE_110139` and `PE_111151`). This allows you to explore all
functions immediately after installation without waiting for large
downloads.

When you are ready to work with the complete 136-catchment dataset
(approx. 120 MB zip, extracting to 186 MB), you can download it directly
from Zenodo (DOI: 10.5281/zenodo.20058779):

``` r

library(rcamelspe)

# Download and extract the full dataset to user data directory
download_pe_data()
```

------------------------------------------------------------------------

## Quick Start Example

``` r

library(rcamelspe)
```

### 1. Load Station Metadata & Data Dictionary

Read the gauging station metadata or inspect the unified data
dictionary:

``` r

# Gauging stations
stations <- load_pe_metadata(type = "stations")
head(stations[, c("gauge_id", "gauge_name", "gauge_region", "gauge_elev")])
#>      gauge_id             gauge_name gauge_region gauge_elev
#> 1 PE_472A9204                 Chilca     Atlantic       2770
#> 2   PE_210003             Huancasaya     Titicaca       4327
#> 3   PE_204617               Huatiapa      Pacific        684
#> 4 PE_472935F2      Intihuatana Km105     Atlantic       2166
#> 5   PE_210406 Puente Isla Cabanillas     Titicaca       3837
#> 6   PE_270503       Puente Zapatilla     Titicaca       3836

# Data dictionary
dict <- read_dictionary(category = "climatic")
head(dict[, c("variable", "description", "unit")])
#>         variable                                   description      unit
#> 1       gauge_id                          Catchment identifier      <NA>
#> 2         p_mean                      Mean daily precipitation    mm/day
#> 3       pet_mean Mean daily potential evapotranspiration (PET)    mm/day
#> 4        aridity       Ratio of mean PET to mean precipitation      <NA>
#> 5  p_seasonality       Seasonality and timing of precipitation      <NA>
#> 6 high_prec_freq          Frequency of high precipitation days days/year
```

------------------------------------------------------------------------

### 2. Load and Merge Catchment Attributes

Retrieve topographic, geologic, soil, land cover, climatic indices,
hydrological signatures, or human intervention attributes:

``` r

# Load merged topographic and landcover attributes
attrs <- load_pe_attributes(c("topographic", "landcover"))
head(attrs[, c("gauge_id", "area", "elev_mean", "forest_perc")])
#>      gauge_id      area elev_mean forest_perc
#> 1 PE_472A9204  9187.868  4210.225       1.389
#> 2   PE_210003  2008.790  4659.078       0.050
#> 3   PE_204617 13224.802  4213.036       1.373
#> 4 PE_472935F2  9576.154  4196.945       1.876
#> 5   PE_210406  2867.025  4467.149       0.000
#> 6   PE_270503   390.800  3990.867       0.000
```

------------------------------------------------------------------------

### 3. Load Daily Time Series (Highly Optimized)

Load time series for specific catchments, filter by date range, and
select only required variables at scan time:

``` r

# Load precipitation and observed streamflow with date filter
ts_data <- load_pe_timeseries(
  gauge_ids = "PE_110139", 
  variables = c("prec", "flow_obs"),
  start_date = "2000-01-01",
  end_date = "2000-06-30"
)
head(ts_data)
#>         date  gauge_id  prec flow_obs
#> 1 2000-01-01 PE_110139 5.758       NA
#> 2 2000-01-02 PE_110139 3.417       NA
#> 3 2000-01-03 PE_110139 5.581       NA
#> 4 2000-01-04 PE_110139 5.377       NA
#> 5 2000-01-05 PE_110139 3.782       NA
#> 6 2000-01-06 PE_110139 7.771       NA
```

------------------------------------------------------------------------

### 4. Access Geospatial Layers & Plotting

Load catchment boundaries and station locations as `sf` objects, and
plot them:

``` r

# Catchment boundaries
catchments <- load_pe_geospatial(type = "catchments")
gauges <- load_pe_geospatial(type = "gauges")

# Plot time series
p_ts <- plot_pe_timeseries(ts_data, variable = "prec")

# Plot catchments with gauge overlays
p_map <- plot_pe_catchments(catchments, gauges = gauges)
```

------------------------------------------------------------------------

### 5. Full Drop-in Compatibility with `RCamelsPE`

Existing scripts written for `RCamelsPE` run without any modifications:

``` r

# Compatible syntax:
stations <- read_metadata()
dict     <- read_dictionary(category = "topographic")
attrs    <- read_attributes(type = "topographic")
ts       <- read_timeseries(gauge_id = "PE_110139", vars = c("date", "prec", "flow_obs"))
spatial  <- read_geospatial(type = "catchments")
```
