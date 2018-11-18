#' Get the vertices of a given hexagon (or pentagon), as an array of [lat, lng] points
#'
#' @param h3_index h3 index
#'
#' @export
h3_to_geo_boundary <- function(h3_index) {
  # h3js_call("h3.h3ToGeoBoundary", h3_index)
  res <- h3js_map("h3ToGeoBoundary", h3_index)
  if (length(dim(res)) == 3)
    return(aperm(res, c(2,3,1)))
  res
}
