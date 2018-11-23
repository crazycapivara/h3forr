coords <- c(37.3615593, -122.0553238)
h3_index <- geo_to_h3(coords)

k_ring_distances(h3_index, 2)[[3]] %>%
  h3_to_geo_boundary() %>%
  geo_boundary_to_sf() %>%
  plot()
