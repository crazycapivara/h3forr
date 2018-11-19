
<!-- README.md is generated from README.Rmd. Please edit that file -->
h3forr
======

Provides R bindings for [H3](https://uber.github.io/h3/), a hexagonal hierarchical spatial indexing system.

Installation
------------

You can install h3forr from github with:

``` r
# install.packages("devtools")
devtools::install_github("crazycapivara/h3forr")
```

Quickstart
----------

Core functions:

``` r
library(h3forr)

# Convert a lat/lng point to a hexagon index at resolution 7
coords <- c(37.3615593, -122.0553238)
h3_index <- geo_to_h3(coords, res = 7)
h3_index
#> [1] "87283472bffffff"

# Get the center of the hexagon
h3_to_geo(h3_index)
#> [1]   37.35172 -122.05033

# Get the vertices of the hexagon
h3_to_geo_boundary(h3_index, format_as_geojson = FALSE)
#>          [,1]      [,2]
#> [1,] 37.34110 -122.0416
#> [2,] 37.35290 -122.0340
#> [3,] 37.36352 -122.0428
#> [4,] 37.36234 -122.0591
#> [5,] 37.35054 -122.0666
#> [6,] 37.33992 -122.0579
```
