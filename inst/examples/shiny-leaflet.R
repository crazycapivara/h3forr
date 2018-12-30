library(shiny)
library(leaflet)
library(h3forr)

view <- fluidPage(
  h1("H3 for R"),
  sliderInput("res", "Resolution", min = 5, max = 7, value = 6),
  leafletOutput("map"),
  style = "font-family: Helvetica, Arial, sans-serif;"
)

controller <- function(input, output) {
  get_result <- reactive({
    hexbins(road_safety_greater_manchester, res = input$res)
  })

  output$map <- renderLeaflet({
    leaflet(data = tibble::as_tibble(road_safety_greater_manchester)) %>%
      addProviderTiles("Stamen.Toner") %>%
      fitBounds(~min(lng), ~min(lat), ~max(lng), ~max(lat))
  })

  observe({
    result <- get_result()
    pal <- colorBin("YlOrRd", domain = result$hexagons$count)
    leafletProxy("map", data = result$hexagons) %>%
      clearShapes() %>%
      addPolygons(
        weight = 2,
        color = "white",
        fillColor = ~ pal(count),
        fillOpacity = 0.8,
        label = ~ sprintf("%i accidents", count),
        popup = result$hexagons$h3_index
      )
  })
}

if (interactive()) shinyApp(view, controller)
