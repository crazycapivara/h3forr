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
#' @note Unlike \code{\link{k_ring}},
#'   this function will throw an error if there is a pentagon anywhere in the ring.
#'
#' @inheritParams k_ring
#'
#' @export
hex_ring <- function(h3_index, ring_size = 1) {
  h3js_map("hexRing", h3_index, ring_size)
}

## TODO: S3 method for sf objects
## -----
#' Get all hexagons with centers contained in a given polygon
#'
#' @inheritParams geo_to_h3
#' @param is_geojson expect [lng, lat] pairs instead of [lat, lng]?
#'
#' @example inst/examples/api-reference/polyfill.R
#'
#' @name polyfill
#' @export
polyfill <- function(coords, res = 7, is_geojson = TRUE) {
  UseMethod("polyfill", coords)
}

#' @name polyfill
#' @export
polyfill.matrix <- function(coords, res = 7, is_geojson = TRUE) {
  h3js("polyfill", coords, res, is_geojson)
}

#' @name polyfill
#' @export
polyfill.data.frame <- function(coords, res = 7, is_geojson = TRUE) {
  h3js("polyfill", as.matrix(coords), res, is_geojson)
}

#' Get the outlines of a set of hexagons
#'
#' Returns GeoJSON MultiPolygon format
#' (an array of polygons, each with an array of loops, each an array of coordinates).
#' Coordinates are returned as [lat, lng] pairs unless GeoJSON is requested.
#'
#' @inheritParams h3_to_geo_boundary
#'
#' @example inst/examples/api-reference/h3-set-to-multipolygon.R
#'
#' @export
h3_set_to_multi_polygon <- function(h3_index, format_as_geojson = TRUE) {
  res <- h3js("h3SetToMultiPolygon", h3_index, format_as_geojson) %>%
    as.vector() %>% matrix(ncol = 2)
  if (format_as_geojson) res %<>% h3forr_class("lng_lat_closed")

  res
}
