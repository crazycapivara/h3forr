quakes[1:3, c("lat", "long")] %>%
  geo_to_h3() %>%
  h3_to_geo()
