#' Get the [lat, lon] center of a given hexagon
#'
#' @param h3_index H3 index
#'
#' @example inst/examples/api-examples/h3-to-geo.R
#'
#' @export
h3_to_geo <- function(h3_index) {
  h3js_map("h3ToGeo", h3_index)
}
