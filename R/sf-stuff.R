#' Parse array to sf object
#'
#' @param data array returned from \link{h3_to_geo_boundary}
#'
#' @export
h3_as_sf <- function(data) {
  features <- lapply(1:dim(data)[3], function(i) {
    list(data[, , i]) %>%
      sf::st_polygon()
  })
  sf::st_sfc(features, crs = 4326) %>%
    sf::st_sf()
}
