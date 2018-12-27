#' Get the vertices of a given hexagon (or pentagon)
#'
#' Get the vertices of a given hexagon (or pentagon) either as an array of [lat, lng] points
#' or as GeoJSON output: [lng, lat] points and closed loops.
#'
#' @param h3_index character vector representing H3 indexes
#' @param format_as_geojson provide GeoJSON output: [lng, lat] and closed loops?
#'
#' @return matrix with [lat, lng] or [lng, lat] points if \code{format_as_geojson = TRUE};
#' Furthermore, GeoJSON format returns closed loops; list of matrices if multiple indexes
#' are supplied
#'
#' @seealso \link{geo_boundary_to_sf} and \link{geo_to_sf}
#'
#' @export
h3_to_geo_boundary <- function(h3_index, format_as_geojson = TRUE) {
  result <- h3js_map("h3ToGeoBoundary", h3_index, format_as_geojson)
  if (length(dim(result)) == 3) result %<>% purrr::array_tree(1)

  if (format_as_geojson) result %<>% h3forr_class("lng_lat_closed")

  result
}
