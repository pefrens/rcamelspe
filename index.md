# rcamelspe

The goal of `rcamelspe` is to provide an efficient and user-friendly R
interface to download, load, filter, and manage the **CAMELS-PE**
(Catchment Attributes and Meteorology for Large-sample Studies - Peru)
dataset.

CAMELS-PE includes daily meteorological and hydrological time series,
static catchment attributes, and geospatial representations for **136
catchments** distributed across the Pacific, Atlantic, and Titicaca
hydrographic regions of Peru.

To manage the volume of records (over 2.2 million rows of daily climate
data), the package is designed using: - **`arrow`**: for
high-performance reading of large files. - **`collapse`**: for fast data
frame subsetting, selection, binding, and join operations.

------------------------------------------------------------------------

## Installation

You can install the development version of `rcamelspe` from GitHub with:

``` r

# install.packages("devtools")
devtools::install_github("pefrens/rcamelspe")
```

------------------------------------------------------------------------

## Downloading the Dataset

You can programmatically download and extract the dataset (approx. 120
MB zip, extracting to 186 MB) directly from the Zenodo repository
(`https://doi.org/10.5281/zenodo.20058779`):

``` r

library(rcamelspe)

# Download and extract the dataset to a folder named "data-raw"
download_pe_data(dest_dir = "data-raw")
```

This will automatically download, extract, and register the dataset path
in the package session.

------------------------------------------------------------------------

## Quick Start Example

This example demonstrates how to configure paths, load station metadata,
read catchment attributes, load climate daily timeseries, and access
geospatial boundaries.

``` r

library(rcamelspe)

# If the folder was extracted to a custom location, configure it:
# set_camels_pe_path("data-raw/CAMELS-PE")
```

### 1. Load Station Metadata

Read the list of all 136 gauging stations included in the dataset:

``` r

stations <- load_pe_metadata(type = "stations")
head(stations[, c("gauge_id", "gauge_name", "gauge_region", "gauge_elev")])
#>       gauge_id              gauge_name gauge_region gauge_elev
#> 1  PE_472A9204                  Chilca     Atlantic       2770
#> 2    PE_210003              Huancasaya     Titicaca       4327
#> 3    PE_204617                Huatiapa      Pacific        684
#> 4  PE_472935F2       Intihuatana Km105     Atlantic       2166
#> 5    PE_210406 Puente Isla Cabanillas     Titicaca       3837
#> 6    PE_270503        Puente Zapatilla     Titicaca       3836
```

------------------------------------------------------------------------

### 2. Load and Merge Catchment Attributes

Retrieve topographic, geologic, soil, land cover, climatic indices,
hydrological signatures, or human intervention attributes. If
`attributes = "all"`, all 7 static attribute tables are merged:

``` r

# Load and merge topographic and landcover attributes
attrs <- load_pe_attributes(c("topographic", "landcover"))
head(attrs[, c("gauge_id", "area", "elev_mean", "forest_perc", "agricul_perc")])
#>       gauge_id    area elev_mean forest_perc agricul_perc
#> 1  PE_472A9204  354.33    3822.4       44.27         7.11
#> 2    PE_210003  194.25    4232.0        0.00         0.00
#> 3    PE_204617  842.12    2583.5       11.23        14.02
#> 4  PE_472935F2  230.15    1455.0       18.42         6.97
#> 5    PE_210406 2058.44    3349.0       16.39         9.41
#> 6    PE_270503 2181.12    3187.0       17.25         8.08
```

------------------------------------------------------------------------

### 3. Loading daily timeseries (Highly Optimized)

You can load time series for a subset of stations or the entire
dataset. - **Optimization**: If 10 or fewer catchments are requested,
the package reads individual catchment CSV files, avoiding parsing the
186 MB main database. If more are requested, it reads the main database
using `arrow` and filters it instantly using `collapse`.

``` r

# Load precipitation and observed flow for two specific catchments
ts_sub <- load_pe_timeseries(
  gauge_ids = c("PE_110139", "PE_111151"), 
  variables = c("prec", "flow_obs")
)
summary(ts_sub)
#>       date             gauge_id              prec             flow_obs      
#>  Min.   :1981-01-01   Length:32876       Min.   :  0.0000   Min.   : 0.1020  
#>  1st Qu.:1992-04-01   Class :character   1st Qu.:  0.0100   1st Qu.: 1.3450  
#>  Median :2003-07-02   Mode  :character   Median :  0.4260   Median : 2.5020  
#>  Mean   :2003-07-02                      Mean   :  2.1020   Mean   : 4.8620  
#>  3rd Qu.:2014-10-01                      3rd Qu.:  2.4080   3rd Qu.: 5.5320  
#>  Max.   :2025-12-31                      Max.   :102.5000   Max.   :88.6050  
#>                                          NA's   :612        NA's   :2240     
```

------------------------------------------------------------------------

### 4. Access Geospatial Layers

Load catchment boundaries (polygon) or station gauge locations (points)
as `sf` spatial objects:

``` r

# Load catchment boundaries for a specific subset of gauges
catchments_sf <- load_pe_geospatial(
  type = "catchments", 
  gauge_ids = c("PE_110139", "PE_111151")
)
print(catchments_sf)
#> Simple feature collection with 2 features and 1 field
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -72.843 ymin: -16.997 xmax: -69.213 ymax: -13.185
#> Geodetic CRS:  WGS 84
#>     gauge_id                       geometry
#> 1  PE_110139 MULTIPOLYGON (((-72.343 -1...
#> 2  PE_111151 MULTIPOLYGON (((-69.213 -1...
```
