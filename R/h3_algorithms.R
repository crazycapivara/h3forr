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

#' Get all hexagons in a k-ring around a given center, in an array of arrays ordered by distance from the origin.
#'
#' The order of the hexagons within each ring is undefined.
#'
#' @inheritParams k_ring
#'
#' @example inst/examples/api-examples/k-ring-distances.R
#'
#' @export
k_ring_distances <- function(h3_index, ring_size = 1) {
  h3js_map("kRingDistances", h3_index, ring_size)
}
