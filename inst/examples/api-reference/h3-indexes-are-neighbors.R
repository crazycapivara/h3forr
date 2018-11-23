coords <- c(37.3615593, -122.0553238)
h3_index <- geo_to_h3(coords)
neighbors <- k_ring(h3_index, 2)

h3_indexes_are_neighbors(neighbors, h3_index)
