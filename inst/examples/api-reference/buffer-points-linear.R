library(sf)
library(leaflet)

bart_stations <- system.file("geojson/bart_stations.geojson", package = "h3forr") %>%
  st_read(quiet = TRUE)

buffer <- buffer_points_linear(bart_stations, radius = 2, res = 8)
hexagons <- h3_to_geo_boundary(buffer$h3_index) %>% geo_boundary_to_sf()

pal <- colorNumeric("Blues", buffer$norm)

map <- leaflet() %>% addTiles() %>%
  addPolygons(
    data = hexagons,
    fillOpacity = 0.9,
    fillColor = pal(buffer$norm),
    weight = 1,
    color = "white",
    label = sprintf("%s", buffer$norm)
  ) %>%
  addMarkers(data = bart_stations)

if (interactive()) map
