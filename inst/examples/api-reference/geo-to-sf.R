coords <- c(37.3615593, -122.0553238)

h3_index <- geo_to_h3(coords, 7)
h3_indexes <- k_ring(h3_index)

# Single center point
h3_to_geo(h3_index) %>% geo_to_sf()

# Multiple center points
h3_to_geo(h3_indexes) %>% geo_to_sf()

# Boundary points (single hexagon)
h3_to_geo_boundary(h3_index, format_as_geojson = FALSE) %>%
  geo_to_sf()

# Boundary points (multiple hexagons)
h3_to_geo_boundary(h3_indexes, format_as_geojson = FALSE) %>%
  geo_to_sf()
