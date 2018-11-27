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
