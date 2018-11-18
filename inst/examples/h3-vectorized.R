library(geojsonio)
library(h3forr)

h3_index <- geo_to_h3_map(us_cities[1:50, ], "lat", "long")
h3_to_geo_boundary(h3_index)
