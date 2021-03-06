#' Get the outlines of a set of hexagons
#'
#' @inheritParams h3_to_geo_boundary
#'
#' @example inst/examples/api-reference/h3-set-to-multi-polygon.R
#'
#' @export
h3_set_to_multi_polygon <- function(h3_index, format_as_geojson = TRUE) {
  f <- function(x) as.vector(x) %>% matrix(ncol = 2)
  result <- h3js("h3SetToMultiPolygon", h3_index, format_as_geojson)
  if (is.list(result)) result %<>% lapply(f)
  else result %<>% f()

  if (format_as_geojson) result %<>% h3forr_class("lng_lat_closed")

  result
}
