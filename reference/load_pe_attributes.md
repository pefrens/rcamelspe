# Load CAMELS-PE catchment attributes

Loads one or more catchment attribute files and merges them by
`gauge_id`. High-performance implementation using 'arrow' and
'collapse'.

## Usage

``` r
load_pe_attributes(
  attributes = "all",
  gauge_ids = NULL,
  variables = NULL,
  path = get_camels_pe_path()
)
```

## Arguments

- attributes:

  Character vector. The attribute groups to load. Can be any combination
  of `"topographic"`, `"climatic"`, `"geologic"`, `"soil"`,
  `"landcover"`, `"intervention"`, and `"signatures"`, or `"all"`
  (default) to load and merge all attribute tables. Aliases
  `"hydrological"` (for `"signatures"`) and `"human_intervention"` (for
  `"intervention"`) are also supported.

- gauge_ids:

  Character vector. Optional gauge identifiers to filter the returned
  attributes. If `NULL`, attributes for all catchments are returned.

- variables:

  Character vector or `NULL`. Optional variable names to retain in the
  returned table. If `NULL`, all variables in the selected attribute
  groups are returned.

- path:

  Character string. Path to the CAMELS-PE dataset directory. If `NULL`,
  retrieved automatically via
  [`get_camels_pe_path()`](https://pefrens.github.io/rcamelspe/reference/get_camels_pe_path.md).

## Value

A `data.frame` containing the merged catchment attributes with
`gauge_id` as primary identifier.

## Details

CAMELS-PE v1.0.1 documents 79 attributes in seven thematic tables.
Hydrological signatures are derived from simulated streamflow, not
observations.

## Examples

``` r
# Load all attributes merged
attrs_all <- load_pe_attributes()
head(attrs_all)
#>    gauge_id     area perimeter elev_min elev_max elev_mean elev_median
#> 1 PE_110139  360.584  1348.403  3009.65  5292.85  4534.981    4631.856
#> 2 PE_111151 1263.804   887.330   866.67  5294.93  3542.298    3695.919
#>   slope_mean p_mean pet_mean aridity p_seasonality high_prec_freq high_prec_dur
#> 1      3.902  2.062    3.185   1.544         0.952         10.111         1.349
#> 2     22.799  1.504    3.231   2.149         0.960         13.806         1.586
#>   high_prec_timing low_prec_freq low_prec_dur low_prec_timing geol_class_1st
#> 1              DJF       211.944        8.499             JJA             sc
#> 2              DJF       237.639       10.248             JJA             vi
#>   geol_class_1st_perc geol_class_2nd geol_class_2nd_perc inter_volca_rocks_perc
#> 1               62.87             vi               21.48                  21.48
#> 2               61.18             pa               18.50                  61.18
#>   geol_porosity geol_permeability inceptisols_perc entisols_perc alfisols_perc
#> 1         0.087           -12.483            94.43          4.36          1.20
#> 2         0.088           -13.230            71.15         22.95          4.04
#>   ultisols_perc aridisols_perc gelisols_perc oxisols_perc mollisols_perc
#> 1          0.01            0.0          0.00         0.00              0
#> 2          1.48            0.2          0.11         0.07              0
#>   vertisols_perc soil_dominant_class agricul_perc forest_perc non_veget_perc
#> 1              0    inceptisols_perc        1.911       1.827          0.713
#> 2              0    inceptisols_perc       11.382       3.511         13.845
#>   non_woody_perc water_perc non_forest_perc non_identi_perc land_dominant_class
#> 1         95.244      0.305               0               0      non_woody_perc
#> 2         71.132      0.130               0               0      non_woody_perc
#>   surface_adh_n surface_adh_vol surface_adh_use groundwater_adh_n
#> 1             0               0            None                 0
#> 2             0               0            None                 0
#>   groundwater_adh_vol groundwater_adh_use reservoir_n reservoir_vol
#> 1                   0                None           1            NA
#> 2                   0                None          10          27.9
#>   reservoir_use q_mean runoff_ratio stream_elas baseflow_index slope_fdc
#> 1    Irrigation  1.109        0.538       0.819          0.791     0.641
#> 2    Irrigation  0.396        0.263       1.339          0.571     1.466
#>   hfd_mean    Q5   Q95 high_q_freq high_q_dur low_q_freq low_q_dur zero_q_freq
#> 1  180.811 0.395 2.424       0.000         NA      0.000        NA           0
#> 2  180.486 0.037 1.466      13.306      7.831     64.639    22.488           0

# Load only topographic and climatic attributes
attrs_sub <- load_pe_attributes(c("topographic", "climatic"))
head(attrs_sub)
#>    gauge_id     area perimeter elev_min elev_max elev_mean elev_median
#> 1 PE_110139  360.584  1348.403  3009.65  5292.85  4534.981    4631.856
#> 2 PE_111151 1263.804   887.330   866.67  5294.93  3542.298    3695.919
#>   slope_mean p_mean pet_mean aridity p_seasonality high_prec_freq high_prec_dur
#> 1      3.902  2.062    3.185   1.544         0.952         10.111         1.349
#> 2     22.799  1.504    3.231   2.149         0.960         13.806         1.586
#>   high_prec_timing low_prec_freq low_prec_dur low_prec_timing
#> 1              DJF       211.944        8.499             JJA
#> 2              DJF       237.639       10.248             JJA

# Load attributes for specific stations
attrs_sel <- load_pe_attributes(gauge_ids = c("PE_110139", "PE_111151"))
attrs_sel
#>    gauge_id     area perimeter elev_min elev_max elev_mean elev_median
#> 1 PE_110139  360.584  1348.403  3009.65  5292.85  4534.981    4631.856
#> 2 PE_111151 1263.804   887.330   866.67  5294.93  3542.298    3695.919
#>   slope_mean p_mean pet_mean aridity p_seasonality high_prec_freq high_prec_dur
#> 1      3.902  2.062    3.185   1.544         0.952         10.111         1.349
#> 2     22.799  1.504    3.231   2.149         0.960         13.806         1.586
#>   high_prec_timing low_prec_freq low_prec_dur low_prec_timing geol_class_1st
#> 1              DJF       211.944        8.499             JJA             sc
#> 2              DJF       237.639       10.248             JJA             vi
#>   geol_class_1st_perc geol_class_2nd geol_class_2nd_perc inter_volca_rocks_perc
#> 1               62.87             vi               21.48                  21.48
#> 2               61.18             pa               18.50                  61.18
#>   geol_porosity geol_permeability inceptisols_perc entisols_perc alfisols_perc
#> 1         0.087           -12.483            94.43          4.36          1.20
#> 2         0.088           -13.230            71.15         22.95          4.04
#>   ultisols_perc aridisols_perc gelisols_perc oxisols_perc mollisols_perc
#> 1          0.01            0.0          0.00         0.00              0
#> 2          1.48            0.2          0.11         0.07              0
#>   vertisols_perc soil_dominant_class agricul_perc forest_perc non_veget_perc
#> 1              0    inceptisols_perc        1.911       1.827          0.713
#> 2              0    inceptisols_perc       11.382       3.511         13.845
#>   non_woody_perc water_perc non_forest_perc non_identi_perc land_dominant_class
#> 1         95.244      0.305               0               0      non_woody_perc
#> 2         71.132      0.130               0               0      non_woody_perc
#>   surface_adh_n surface_adh_vol surface_adh_use groundwater_adh_n
#> 1             0               0            None                 0
#> 2             0               0            None                 0
#>   groundwater_adh_vol groundwater_adh_use reservoir_n reservoir_vol
#> 1                   0                None           1            NA
#> 2                   0                None          10          27.9
#>   reservoir_use q_mean runoff_ratio stream_elas baseflow_index slope_fdc
#> 1    Irrigation  1.109        0.538       0.819          0.791     0.641
#> 2    Irrigation  0.396        0.263       1.339          0.571     1.466
#>   hfd_mean    Q5   Q95 high_q_freq high_q_dur low_q_freq low_q_dur zero_q_freq
#> 1  180.811 0.395 2.424       0.000         NA      0.000        NA           0
#> 2  180.486 0.037 1.466      13.306      7.831     64.639    22.488           0
```
