#' Get the hexagons containing a [lat, lon] point
#'
#' @param coords [lat, lng] point [vector, data.frame or sf object]
#' @param res resolution of hexagon to return
#'
#' @return H3 index vector
#'
#' @example inst/examples/api-reference/geo-to-h3.R
#'
#' @name geo_to_h3
#' @export
geo_to_h3 <- function(coords, res = 7) {
  UseMethod("geo_to_h3", coords)
}

#' @name geo_to_h3
#' @export
geo_to_h3.numeric <- function(coords, res = 7) {
  h3js_map("geoToH3", list(coords), res)
}

#' @name geo_to_h3
#' @export
geo_to_h3.matrix <- function(coords, res = 7) {
  h3js_map("geoToH3", coords, res)
}

#' @name geo_to_h3
#' @export
geo_to_h3.data.frame <- function(coords, res = 7) {
  h3js_map("geoToH3", as.matrix(coords), res)
}

#' @name geo_to_h3
#' @export
geo_to_h3.sf <- function(coords, res = 7) {
  h3js_map("geoToH3", sf::st_coordinates(coords)[, c("Y", "X")], res)
}
