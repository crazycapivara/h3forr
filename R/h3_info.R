#' Get the total count of hexagons in the world at a given resolution
#'
#' js pendant: \code{h3.numHexagons(res) => number}
#'
#' @param res resolution between 0 and 15 [numeric vector]
#'
#' @note For resolutions above 8 the exact count cannot be represented in a JavaScript 32-bit number.
#'   So use with caution when applying further operations to the output.
#'
#' @return numeric vector
#'
#' @examples num_hexagons(2:7)
#'
#' @export
num_hexagons <- function(res = 7) {
  h3js_map("numHexagons", res)
}

#' Get the average hexagon edge length at a given resolution
#'
#' js pendant: \code{h3.edgeLength(res, unit) => number}
#'
#' @inheritParams num_hexagons
#' @param unit unit, either \code{m} for meters or \code{km} for kilometers
#'
#' @return numeric vector
#'
#' @examples edge_length(1:4, unit = "km")
#'
#' @export
edge_length <- function(res = 7, unit = "m") {
  h3js_map("edgeLength", res, unit)
}

#' Get the average hexagon area at a given resolution
#'
#' js pendant: \code{h3.hexArea(res, unit) => number}
#'
#' @inheritParams num_hexagons
#' @param unit unit, either \code{m2} or \code{km2}
#'
#' @return numeric vector
#'
#' @examples hex_area(1:4, unit = "km2")
#'
#'
#' @export
hex_area <- function(res = 7, unit = "m2") {
  h3js_map("hexArea", res, unit)
}

#' Get the grid distance between two hex indexes
#'
#' js pendant: \code{h3.h3Distance(origin, destination) => number}
#'
#' @note This function may fail to find the distance between two indexes
#'   if they are very far apart or on opposite sides of a pentagon.
#'
#' @param origin_h3_index H3 index (origin) [vector of indexes]
#' @param destination_h3_index H3 index (destination) [single index]
#'
#' @return numeric vector
#'
#' @example inst/examples/api-reference/h3-distance.R
#'
#' @export
h3_distance <- function(origin_h3_index, destination_h3_index) {
  h3js_map("h3Distance", origin_h3_index, destination_h3_index)
}
