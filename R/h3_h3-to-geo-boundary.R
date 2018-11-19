#' Get the vertices of a given hexagon (or pentagon)
#'
#' Returns the vertices either as an array of [lat, lng] points
#' or as GeoJSON output: [lng, lat] and closed loops.
#'
#' @param h3_index h3 index
#' @param format_as_geojson provide GeoJSON output: [lng, lat] and closed loops?
#'
#' @export
h3_to_geo_boundary <- function(h3_index, format_as_geojson = TRUE) {
  res <- h3js_map("h3ToGeoBoundary", h3_index, format_as_geojson)
  if (length(dim(res)) == 3) {
    return(aperm(res, c(2,3,1)))
  }

  res
}
