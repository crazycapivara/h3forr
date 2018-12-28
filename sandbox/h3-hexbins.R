hexbins_legacy <- function(data, res = 7, lat = "lat", lng = "lng") {
  if (inherits(data, "matrix")) data %<>% as.data.frame()

  if (inherits(data, "data.frame")) {
    data %<>% sf::st_as_sf(coords = c(lng, lat), crs = 4326)
  }

  h3_indexes <- geo_to_h3(data, res)
  data$h3_index <- h3_indexes

  h3_index_tbl <- table(h3_indexes) %>%
    tibble::as_tibble()
  colnames(h3_index_tbl) <- c("h3_index", "count")

  hexagons <- h3_to_geo_boundary(h3_index_tbl$h3_index) %>%
    geo_boundary_to_sf()

  hexagons[, c("h3_index", "count")] <- h3_index_tbl

  list(
    hexagons = hexagons,
    data = data
  )
}
