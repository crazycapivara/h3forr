library(leaflet)

result <- hexbins(road_safety_greater_manchester)

pal <- colorBin("YlOrRd", domain = result$hexagons$count)

map <- leaflet(data = result$hexagons) %>%
  addProviderTiles("Stamen.Toner") %>%
  addPolygons(
    weight = 2,
    color = "white",
    fillColor = ~ pal(count),
    fillOpacity = 0.8,
    label = ~ sprintf("%i accidents", count),
    popup = result$hexagons$h3_index
  )

if (interactive()) map
