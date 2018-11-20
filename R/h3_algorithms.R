#' Get all hexagons in a k-ring around a given center.
#'
#' The order of the hexagons is undefined.
#'
#' @param h3_index H3 index of center hexagon
#' @param ring_size number of rings
#'
#' @example inst/examples/api-examples/k-ring.R
#'
#' @export
k_ring <- function(h3_index, ring_size = 1) {
  res <- h3js_map("kRing", h3_index, ring_size)
  if (class(res) == "matrix") {
    return(purrr::array_tree(res, 1))
  }

  res
}
