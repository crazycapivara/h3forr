library(data.table)
library(sf)
library(leaflet)
library(h3forr)

# Personal injury road accidents in GB from 1979
data_url <- paste0(
  "https://raw.githubusercontent.com/",
  "uber-common/deck.gl-data/",
  "master/examples/3d-heatmap/heatmap-data.csv"
)

# Get data
accidents <- fread(data_url) %>%
  na.omit() %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326)

# Set center point
lng <- -2.23743
lat <- 53.48095
manchester <- st_point(c(lng, lat)) %>%
  st_sfc(crs = 4326)

# Find accidents within buffer around center point
accidents_within_buffer <- st_buffer(manchester, 0.3) %>%
  st_sfc(crs = 4326) %>%
  st_intersection(accidents) %>%
  st_sf()

# Get hexagons and count accidents/hexagon
h3_index <- geo_to_h3(accidents_within_buffer)

frequency_tbl <- table(h3_index) %>%
  as.data.frame(responseName = "count")

hexagons <- h3_to_geo_boundary(frequency_tbl$h3_index) %>%
  geo_boundary_to_sf()

hexagons$count <- frequency_tbl$count

# Show result on leaflet map
pal <- colorBin("YlOrRd", domain = hexagons$count)

map <- leaflet(data = hexagons) %>%
  addTiles() %>%
  addPolygons(
    weight = 2,
    color = "white",
    fillColor = ~ pal(count),
    fillOpacity = 0.6,
    popup = ~ sprintf("%i accidents", count)
  ) %>%
  addLegend(
    pal = pal,
    values = ~ count,
    opacity = 0.7,
    title = "Accidents",
    position = "bottomleft"
  ) %>%
  setView(lng = lng, lat = lat, zoom = 11)

if (interactive()) map
