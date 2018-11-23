coords <- c(37.36156, -122.05532)

h3_index <- geo_to_h3(coords)

h3_to_parent(h3_index) %>%
  h3_to_geo_boundary() %>%
  geo_boundary_to_sf() %>% plot()

h3_to_geo_boundary(h3_index) %>%
  geo_boundary_to_sf() %>% plot(add = TRUE)
