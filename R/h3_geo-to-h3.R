#' Get hexagons containing [lat, lon] points
#'
#' @param coords [lat, lng] points
#' @param res resolution of hexagons to return
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
geo_to_h3.default <- function(coords, res = 7) {
  h3js_map("geoToH3", list(coords), res)
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
