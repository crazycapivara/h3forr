#' Get all hexagons in a k-ring around a given center
#'
#' @note The order of the hexagons is undefined.
#'
#' @param h3_index character vector representing H3 indexes
#' @param ring_size number of rings
#'
#' @return character vector of H3 indexes;
#' list of character vectors if multiple centers are supplied
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
#' ordered by distance from the origin.
#'
#' @note The order of the hexagons within each ring is undefined.
#'
#' @inheritParams k_ring
#'
#' @return data frame with columns \emph{h3_index} and \emph{distance} (ring number);
#' list of data frames if multiple centers are supplied
#'
#' @example inst/examples/api-reference/k-ring-distances.R
#'
#' @export
k_ring_distances <- function(h3_index, ring_size = 1) {
  h3js_map("kRingDistances", h3_index, ring_size) %>%
    enframe_k_ring()
}

enframe_k_ring <- function(data) {
  f <- function(data) purrr::imap_dfr(data, ~ tibble::tibble(h3_index = .x, distance = .y - 1))
  if (is.list(data[[1]])) return(lapply(data, f))

  f(data)
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
