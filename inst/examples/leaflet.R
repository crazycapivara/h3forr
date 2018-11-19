library(geojsonio)
library(leaflet)

data <- canada_cities[1:10, ]

hexagons <- geo_to_h3(data[, c("lat", "long")]) %>%
  h3_to_geo_boundary() %>%
  h3_as_sf()

leaflet() %>%
  addTiles() %>%
  addPolygons(data = hexagons) %>%
  addMarkers(data = data, popup = ~ name)
