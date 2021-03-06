library(h3forr)

lat <- 37.3615593
lng <- -122.0553238
res <- 7

# Convert a lat/lng point to a hexagon index at resolution 7
h3_index <- geo_to_h3(c(lat, lng), res)

# Get the center of the hexagon
hex_center_coordinates <- h3_to_geo(h3_index)

# Get the vertices of the hexagon
h3_to_geo_boundary(h3_index)
