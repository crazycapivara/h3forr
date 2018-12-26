#' Check whether a given string represents a valid unidirectional edge index
#'
#' @param h3_edge_index character vector representing H3 edge indexes
#'
#' @return boolean vector
#'
#' @export
h3_unidirectional_edge_is_valid <- function(h3_edge_index) {
  h3js_map("h3UnidirectionalEdgeIsValid", h3_edge_index)
}

#' Get an H3 edge index for a given origin and destination H3 index
#'
#' @inheritParams h3_distance
#'
#' @return character vector
#'
#' @export
get_h3_unidirectional_edge <- function(origin_h3_index, destination_h3_index) {
  h3js("getH3UnidirectionalEdge", origin_h3_index, destination_h3_index)
}

#' Check whether two H3 (hexagon) indexes are neighbors (share an edge)
#'
#' @inheritParams h3_distance
#'
#' @return boolean vector
#'
#' @example inst/examples/api-reference/h3-indexes-are-neighbors.R
#'
#' @export
h3_indexes_are_neighbors <- function(origin_h3_index, destination_h3_index) {
  h3js_map("h3IndexesAreNeighbors", origin_h3_index, destination_h3_index)
}

#' Get the origin H3 (hexagon) index from an H3 edge index
#'
#' @inheritParams h3_unidirectional_edge_is_valid
#'
#' @return character vector
#'
#' @export
get_origin_h3_index_from_unidirectional_edge <- function(h3_edge_index) {
  h3js_map("getOriginH3IndexFromUnidirectionalEdge", h3_edge_index)
}

#' Get the destination H3 (hexagon) index from an H3 edge index
#'
#' @inheritParams get_origin_h3_index_from_unidirectional_edge
#'
#' @return character vector
#'
#' @export
get_destination_h3_index_from_unidirectional_edge <- function(h3_edge_index) {
  h3js_map("getDestinationH3IndexFromUnidirectionalEdge", h3_edge_index)
}

#' Get the H3 [origin, destination] index pair from an H3 edge index
#'
#' @inheritParams get_origin_h3_index_from_unidirectional_edge
#'
#' @export
get_h3_indexes_from_unidirectional_edge <- function(h3_edge_index) {
  h3js_map("getH3IndexesFromUnidirectionalEdge", h3_edge_index)
}

#' Get all unidirectional edges for a given H3 index (an edge to every neighbor)
#'
#' @inheritParams h3_to_geo
#'
#' @return chraracter vector representing H3 edge indexes;
#' list of character vectors if multiple indexes are supplied
#'
#' @examples
#' get_sample_h3_index() %>%
#'   get_h3_unidirectional_edges_from_hexagon() %>%
#'   h3_unidirectional_edge_is_valid()
#'
#' @export
get_h3_unidirectional_edges_from_hexagon <- function(h3_index) {
  result <- h3js_map("getH3UnidirectionalEdgesFromHexagon", h3_index)
  if (is.array(result)) result %<>% purrr::array_tree(1)

  result
}

#' Get the vertices of a given edge as an array of [lat, lng] points
#'
#' @note Edges that cross the edge of an icosahedron face may return 3 coordinates.
#'
#' @inheritParams h3_unidirectional_edge_is_valid
#' @param format_as_geojson whether to return [lng, lat] points instead of of [lat, lng]
#'
#' @return numeric matrix (2x2); list of matrices if multiple indexes are supplied
#'
#' @export
get_h3_unidirectional_edge_boundary <- function(h3_edge_index, format_as_geojson = TRUE) {
  result <- h3js_map("getH3UnidirectionalEdgeBoundary", h3_edge_index, format_as_geojson)
  if (!is.matrix(result)) result %<>% purrr::array_tree(1)

  if (format_as_geojson) result %<>% h3forr_class(pkg_env$h3forr_classes$lat_lng)

  result
}
