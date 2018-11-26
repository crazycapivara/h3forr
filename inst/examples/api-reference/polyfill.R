library(sf)

nc <- system.file("shape/nc.shp", package = "sf") %>%
  st_read(quiet = TRUE)

st_geometry(nc[1, ]) %>% plot()

coords <- st_coordinates(nc[1, ])[, c("X", "Y")]
polyfill(coords) %>% h3_to_geo_boundary() %>%
  geo_boundary_to_sf() %>%
  plot(add = TRUE)

list(greater_manchester) %>% st_polygon() %>% st_sfc(crs = 4326) %>%
  plot()

polyfill(greater_manchester, 6) %>%
  h3_to_geo_boundary() %>%
  geo_boundary_to_sf() %>%
  plot(add = TRUE)
