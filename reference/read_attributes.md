# Read CAMELS-PE catchment attributes

Compatibility alias matching the `RCamelsPE::read_attributes()`
interface, powered by the high-performance 'arrow' and 'collapse'
backend of `rcamelspe`.

## Usage

``` r
read_attributes(
  type = "all",
  gauge_id = NULL,
  vars = NULL,
  path = get_camels_pe_path()
)
```

## Arguments

- type:

  Character string. Attribute group to read. One of `"topographic"`,
  `"climatic"`, `"hydrological"`, `"landcover"`, `"geologic"`, `"soil"`,
  `"human_intervention"`, or `"all"`. Default is `"all"`.

- gauge_id:

  Character vector or `NULL`. Optional gauge identifiers.

- vars:

  Character vector or `NULL`. Optional variable names to retain.

- path:

  Character string. Optional path to the CAMELS-PE root directory.

## Value

A `data.frame` with CAMELS-PE catchment attributes.

## Examples

``` r
# Read all attributes using RCamelsPE compatible syntax
attrs <- read_attributes(type = "topographic")
head(attrs)
#>    gauge_id     area perimeter elev_min elev_max elev_mean elev_median
#> 1 PE_110139  360.584  1348.403  3009.65  5292.85  4534.981    4631.856
#> 2 PE_111151 1263.804   887.330   866.67  5294.93  3542.298    3695.919
#>   slope_mean
#> 1      3.902
#> 2     22.799
```
