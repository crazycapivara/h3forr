coords <- c(37.3615593, -122.0553238)
h3_index <- geo_to_h3(coords)

buffer <- k_ring_distances(h3_index, 2)
buffer[buffer$distance %in% c(0, 2), ]$h3_index %>%
  h3_to_geo_boundary() %>%
  geo_boundary_to_sf() %>%
  sf::st_geometry() %>%
  plot(col = "red")
