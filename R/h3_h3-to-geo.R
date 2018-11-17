#' Get the lat,lon center of a given hexagon.
#'
#' @param h3_index h3 index
#'
#' @export
h3_to_geo <- function(h3_index) {
  h3js_call("h3.h3ToGeo", h3_index)
}
