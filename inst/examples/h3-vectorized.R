library(geojsonio)
library(h3forr)

h3_index <- geo_to_h3(us_cities[1:50, c("lat", "long")])
h3_to_geo(h3_index)
h3_to_geo_boundary(h3_index[1])
h3_to_geo_boundary(h3_index)
