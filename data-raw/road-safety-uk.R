library(data.table)
library(sf)
library(h3forr)

# Personal injury road accidents in GB from 1979
data_url <- paste0(
  "https://raw.githubusercontent.com/",
  "uber-common/deck.gl-data/",
  "master/examples/3d-heatmap/heatmap-data.csv"
)

uk_road_accidents <- fread(data_url) %>% na.omit()

city_of_london <- c(51.51279, -0.09184)
manchester <- c(53.48095, -2.23743)

filter_data <- function(data, point, res = 5) {
  data <- st_as_sf(data, coords = c("lng", "lat"), crs = 4326)

  buffer <- geo_to_h3(point, res) %>%
    k_ring() %>%
    h3_to_geo_boundary() %>%
    geo_boundary_to_sf()

  result <- st_intersection(buffer, data) %>%
    st_coordinates() %>%
    .[, c("Y", "X")]

  dimnames(result) <- list(NULL, c("lat", "lng"))
  result
}

road_safety_london <- filter_data(uk_road_accidents, city_of_london, 5) #%>%
road_safety_manchester <- filter_data(uk_road_accidents, manchester, 5)

# usethis::use_data(road_safety_london)
# usethis::use_data(road_safety_manchester)

# test data
library(leaflet)

leaflet() %>% addProviderTiles("Stamen.Toner") %>%
  addCircleMarkers(data = road_safety_london[1:50, 2:1])
