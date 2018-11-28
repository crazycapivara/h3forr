#' Get all hexagons with centers contained in a given polygon
#'
#' @param coords numeric vector, matrix or data.frame with [lat, lng]
#' or [lng, lat] pairs if \code{is_geojson = TRUE};
#' object of class \code{sf} (geom type \code{POLYGON} or \code{MULTIPOLYGON})
#' @param res resolution; number between 0 and 15
#' @param is_geojson boolean; expect [lng, lat] pairs instead of [lat, lng]?
#'
#' @return h3 indexes; character vector or list of character vectors if multiple polygons
#' are supplied
#'
#' @example inst/examples/api-reference/polyfill.R
#'
#' @name polyfill
#' @export
polyfill <- function(coords, res = 7, is_geojson = TRUE) {
  UseMethod("polyfill", coords)
}

#' @name polyfill
#' @export
polyfill.matrix <- function(coords, res = 7, is_geojson = TRUE) {
  h3js("polyfill", coords, res, is_geojson)
}

#' @name polyfill
#' @export
polyfill.data.frame <- function(coords, res = 7, is_geojson = TRUE) {
  h3js("polyfill", as.matrix(coords), res, is_geojson)
}

#' @name polyfill
#' @export
polyfill.list <- function(coords, res = 7, is_geojson = TRUE) {
  h3js_map2("polyfill", coords, res, is_geojson)
}

#' @name polyfill
#' @export
polyfill.sf <- function(coords, res = 7, is_geojson = TRUE) {
  coords <- lapply(1:nrow(coords), function(i) sf::st_coordinates(coords[i, ])[, c("X", "Y")])
  if (length(coords) == 1) return(h3js("polyfill", coords, res, is_geojson))

  h3js_map2("polyfill", coords, res, is_geojson)
}
