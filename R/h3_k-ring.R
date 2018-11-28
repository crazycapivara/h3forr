#' Get all hexagons in a k-ring around a given center
#'
#' @note The order of the hexagons is undefined.
#'
#' @param h3_index character vector representing H3 indexes
#' @param ring_size number of rings
#'
#' @return H3 indexes; list of character vectors if multiple centers are supplied
#'
#' @example inst/examples/api-reference/k-ring.R
#'
#' @export
k_ring <- function(h3_index, ring_size = 1) {
  result <- h3js_map("kRing", h3_index, ring_size)
  if (is.matrix(result)) return(purrr::array_tree(result, 1))

  result
}

#' Get all hexagons in a k-ring around a given center
#'
#' Get all hexagons in a k-ring around a given center
#' as a list of vectors ordered by distance from the origin.
#'
#' @note The order of the hexagons within each ring is undefined.
#'
#' @inheritParams k_ring
#'
#' @return H3 indexes; list of character vectors ordered by distance (ring number);
#' list of lists if multiple centers are supplied
#'
#' @example inst/examples/api-reference/k-ring-distances.R
#'
#' @export
k_ring_distances <- function(h3_index, ring_size = 1) {
  h3js_map("kRingDistances", h3_index, ring_size)
}

#' Get all hexagons in a hollow hexagonal ring centered at origin with sides of a given length
#'
#' @note Unlike \code{\link{k_ring}}, this function will throw an error
#' if there is a pentagon anywhere in the ring.
#'
#' @inheritParams k_ring
#'
#' @export
hex_ring <- function(h3_index, ring_size = 1) {
  h3js_map("hexRing", h3_index, ring_size)
}
