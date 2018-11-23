library(leaflet)
library(h3forr)

h3_index <- get_sample_h3_index()

center <- h3_to_geo(h3_index) %>% geo_to_sf()

hexagon <- h3_to_geo_boundary(h3_index) %>% geo_boundary_to_sf()

h3_edge_index <- get_h3_unidirectional_edges_from_hexagon(h3_index)[1]
edge <- h3_edge_index %>%
  get_h3_unidirectional_edge_boundary(FALSE) %>% geo_to_sf()

hexagon2 <- get_destination_h3_index_from_unidirectional_edge(h3_edge_index) %>%
  h3_to_geo_boundary() %>% geo_boundary_to_sf()

weight = 2

leaflet() %>%
  addProviderTiles("Stamen.Toner") %>%
  addPolygons(data = hexagon, weight = weight) %>%
  addPolygons(data = hexagon2, color = "red", weight = weight) %>%
  addMarkers(data = center) %>%
  addCircleMarkers(data = edge, color = "green", weight = weight)
