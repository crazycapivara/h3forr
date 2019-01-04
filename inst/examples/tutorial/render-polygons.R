library(dplyr)
library(h3forr)

radius <- 4
threshold <- 0.8
h3_indexes <- geo_to_h3(c(37.36156, -122.05532)) %>% k_ring(radius)

hexagons <- h3_to_geo_boundary(h3_indexes) %>%
  geo_boundary_to_sf() %>%
  mutate(
    h3_index = h3_indexes,
    weight = runif(length(geometry)) %>% round(2)
  )

multi_hex <- filter(hexagons, weight > threshold)$h3_index %>%
  h3_set_to_multi_polygon() %>%
  geo_boundary_to_sf()

plot(multi_hex)
