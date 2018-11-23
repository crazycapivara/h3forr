coords <- c(37.36156, -122.05532)

h3_index <- geo_to_h3(coords)
neighbors <- k_ring(h3_index, 2)
h3_distance(neighbors, h3_index)
