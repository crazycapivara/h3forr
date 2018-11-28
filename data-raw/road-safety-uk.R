library(data.table)
library(sf)
library(magrittr)

# Personal injury road accidents in GB from 1979
data_url_road_safety_uk <- paste0(
  "https://raw.githubusercontent.com/",
  "uber-common/deck.gl-data/",
  "master/examples/3d-heatmap/heatmap-data.csv"
)

uk_road_accidents <- fread(data_url_road_safety_uk) %>% na.omit()
uk_road_accidents %<>% st_as_sf(coords = c("lng", "lat"), crs = 4326)

geofabrik_en = "http://download.geofabrik.de/europe/great-britain/england/"

data_url_polygons <- list(
  greater_manchester = paste0(geofabrik_en, "greater-manchester.poly"),
  greater_london = paste0(geofabrik_en, "greater-london.poly")
)

get_polygon <- function(data_url) {
  n <- readLines(data_url) %>% length()
  data <- fread(data_url, skip = 2, nrow = (n - 4)) %>% as.matrix()
  colnames(data) <- c("lng", "lat")
  data
}

to_sf <- function(mtrx) {
  list(mtrx) %>% st_polygon() %>% st_sfc(crs = 4326)
}

get_intersection <- function(poly) {
  result <- st_intersection(poly, uk_road_accidents) %>%
    st_coordinates() %>%
    .[, c("Y", "X")]
  colnames(result) <- c("lat", "lng")
  result
}

greater_manchester_matrix <- get_polygon(data_url_polygons$greater_manchester)
greater_london_matrix <- get_polygon(data_url_polygons$greater_london)

greater_manchester_poly <- to_sf(greater_manchester_matrix)
greater_london_poly <- to_sf(greater_london_matrix)

road_safety_manchester <- get_intersection(greater_manchester_poly)
road_safety_london <- get_intersection(greater_london_poly)

# test data
city_of_london <- c(51.51279, -0.09184)
manchester <- c(53.48095, -2.23743)

library(leaflet)

leaflet() %>% addProviderTiles("Stamen.Toner") %>%
  addPolygons(data = greater_london_poly) %>%
  addMarkers(lat = city_of_london[1], lng = city_of_london[2]) %>%
  addCircles(data = as.data.frame(road_safety_london))

leaflet() %>% addProviderTiles("Stamen.Toner") %>%
  addPolygons(data = greater_manchester_poly) %>%
  addMarkers(lat = manchester[1], lng = manchester[2]) %>%
  addCircles(data = as.data.frame(road_safety_manchester))
