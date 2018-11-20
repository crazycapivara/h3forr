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

#' Get all hexagons in a hollow hexagonal ring centered at origin with sides of a given length.
#'
#' Unlike \code{\link{k_ring}}, this function will throw an error if there is a pentagon anywhere in the ring.
#'
#' @inheritParams k_ring
#'
#' @export
hex_ring <- function(h3_index, ring_size = 1) {
  h3js_map("hexRing", h3_index, ring_size)
}

### TODO: S3 method for sf objects
#' Get all hexagons with centers contained in a given polygon.
#'
#' The polygon is specified with GeoJson semantics as an array of loops.
#' Each loop is an array of [lat, lng] pairs (or [lng, lat] if isGeoJson is specified).
#' The first loop is the perimeter of the polygon, and subsequent loops are expected to be holes.
#'
#' @inheritParams geo_to_h3
#' @param is_geojson expect GeoJson-style [lng, lat] pairs instead of [lat, lng]?
#'
#' @example inst/examples/api-examples/polyfill.R
#'
#' @export
polyfill <- function(coords, res = 7, is_geojson = TRUE) {
  h3js("polyfill", coords, res, is_geojson)
}
