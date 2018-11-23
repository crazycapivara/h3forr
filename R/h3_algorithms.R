#' Get all hexagons in a k-ring around a given center
#'
#' @note The order of the hexagons is undefined.
#'
#' @param h3_index H3 index of center hexagon [vector]
#' @param ring_size number of rings
#'
#' @return H3 index vector or list of H3 index vectors
#'
#' @example inst/examples/api-reference/k-ring.R
#'
#' @export
k_ring <- function(h3_index, ring_size = 1) {
  res <- h3js_map("kRing", h3_index, ring_size)
  if (is.matrix(res)) return(purrr::array_tree(res, 1))

  res
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
#' @return list of H3 index vectors
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

### TODO: S3 method for sf objects
#' Get all hexagons with centers contained in a given polygon
#'
#' The polygon is specified with GeoJson semantics as an array of loops.
#' Each loop is an array of [lat, lng] pairs (or [lng, lat] if \code{is_geoson} is specified).
#' The first loop is the perimeter of the polygon, subsequent loops are expected to be holes.
#'
#' @inheritParams geo_to_h3
#' @param is_geojson expect GeoJson-style [lng, lat] pairs instead of [lat, lng]?
#'
#' @example inst/examples/api-reference/polyfill.R
#'
#' @export
polyfill <- function(coords, res = 7, is_geojson = TRUE) {
  h3js("polyfill", coords, res, is_geojson)
}

#' Get the outlines of a set of H3 hexagons
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
