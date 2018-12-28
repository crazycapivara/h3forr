library(leaflet)

result <- hexbins(road_safety_greater_manchester)
centers <- result$hexagons$h3_index %>% h3_to_geo() %>% geo_to_sf()

pal <- colorBin("YlOrRd", domain = result$hexagons$count)

map <- leaflet(data = result$hexagons) %>%
  addProviderTiles("Stamen.Toner") %>%
  addPolygons(
    weight = 2,
    color = "white",
    fillColor = ~ pal(count),
    fillOpacity = 0.8,
    popup = ~ sprintf("%i accidents", count)
  ) %>%
  addCircleMarkers(
    data =  centers,
    label = result$hexagons$h3_index,
    radius = 5,
    stroke = FALSE,
    fillColor = "blue",
    fillOpacity = 0.5
  )

if (interactive()) map
