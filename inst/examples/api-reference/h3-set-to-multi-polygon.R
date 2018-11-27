coords <- c(37.3615593, -122.0553238)

geo_to_h3(coords) %>%
  k_ring(3) %>%
  h3_set_to_multi_polygon() %>%
  geo_boundary_to_sf() %>%
  plot()
