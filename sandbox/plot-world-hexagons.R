library(sf)

h3_indexes_world <- get_sample_coords() %>% geo_to_h3(res = 0) %>%
  k_ring(10) -> hexagons
hexagons <- h3_indexes_world[!h3_is_pentagon(h3_indexes_world)]
polygons <- h3_to_geo_boundary(hexagons) %>% geo_boundary_to_sf()
# polygons <- h3_to_geo_boundary(h3_indexes_world) %>% geo_boundary_to_sf()
plot(polygons)
polygons3035 <- st_transform(polygons, 3035)
plot(st_geometry(polygons3035[-16, ]), col = "red")
