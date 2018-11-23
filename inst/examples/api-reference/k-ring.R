coords <- c(37.3615593, -122.0553238)

geo_to_h3(coords) %>%
  k_ring() %>%
  h3_to_geo_boundary() %>%
  geo_boundary_to_sf() %>%
  plot()
