mtx_geo <- road_safety_greater_manchester[1:5, ] %>%
  geo_to_h3() %>%
  h3_to_geo()

mtx_geo %>%
  geo_to_sf()
