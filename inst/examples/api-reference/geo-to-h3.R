# numeric
coords <- c(37.3615593, -122.0553238)
geo_to_h3(coords, 7)

# matrix
geo_to_h3(road_safety_greater_manchester[1:10, ], res = 5)

# sf
points <- as.data.frame(greater_manchester) %>%
  sf::st_as_sf(coords = c("lng", "lat"), crs = 4326)
geo_to_h3(points[1:5, ], res = 12)
