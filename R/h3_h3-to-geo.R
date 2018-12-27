#' Get the [lat, lon] center of a given hexagon
#'
#' @param h3_index character vector representing H3 indexes
#'
#' @return numeric vector: [lat, lng];
#' matrix with [lat, lng] pairs if multiple indexes are supplied
#'
#' @example inst/examples/api-reference/h3-to-geo.R
#'
#' @export
h3_to_geo <- function(h3_index) {
  h3js_map("h3ToGeo", h3_index)
}
