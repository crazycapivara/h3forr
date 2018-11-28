#' Check whether a given string represents a valid unidirectional edge
#'
#' @note js pendant: \code{h3.h3UnidirectionalEdgeIsValid(edgeIndex) => boolean}
#'
#' @param h3_edge_index H3 edge index [vector]
#'
#' @return boolean vector
#'
#' @export
h3_unidirectional_edge_is_valid <- function(h3_edge_index) {
  h3js_map("h3UnidirectionalEdgeIsValid", h3_edge_index)
}

#' Get an H3 unidirectional edge index
#'
#' Get an H3 edge index for a given origin and destination H3 index.
#'
#' @note js pendant: \code{h3.getH3UnidirectionalEdge(origin, destination) => H3 edge index}
#'
#' @inheritParams h3_distance
#'
#' @return H3 edge index vector
#'
#' @export
get_h3_unidirectional_edge <- function(origin_h3_index, destination_h3_index) {
  h3js("getH3UnidirectionalEdge", origin_h3_index, destination_h3_index)
}

#' Check whether two H3 indexes are neighbors (share an edge)
#'
#' js pendant: \code{h3.h3IndexesAreNeighbors(origin, destination) => boolean}
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
#' js pendant: \code{h3.getOriginH3IndexFromUnidirectionalEdge(edgeIndex) => H3 index}
#'
#' @param h3_edge_index H3 edge index [vector]
#'
#' @return H3 index vector
#'
#' @export
get_origin_h3_index_from_unidirectional_edge <- function(h3_edge_index) {
  h3js_map("getOriginH3IndexFromUnidirectionalEdge", h3_edge_index)
}

#' Get the destination H3 (hexagon) index from an H3 edge index
#'
#' js pendant: \code{h3.getDestinationH3IndexFromUnidirectionalEdge(edgeIndex) => H3 index}
#'
#' @inheritParams get_origin_h3_index_from_unidirectional_edge
#'
#' @return H3 index vector
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
#' js pendant: \code{h3.getH3UnidirectionalEdgesFromHexagon(h3Index) => Array.<H3EdgeIndex>}
#'
#' @param h3_index H3 index [vector]
#'
#' @return H3 edge index vector or list of H3 edge index vectors
#'
#' @examples
#' get_sample_h3_index() %>%
#'   get_h3_unidirectional_edges_from_hexagon() %>%
#'   h3_unidirectional_edge_is_valid()
#'
#' @export
get_h3_unidirectional_edges_from_hexagon <- function(h3_index) {
  res <- h3js_map("getH3UnidirectionalEdgesFromHexagon", h3_index)
  if (is.array(res)) res %<>% purrr::array_tree(1)

  res
}

#' Get the vertices of a given edge as an array of [lat, lng] points
#'
#' @note Edges that cross the edge of an icosahedron face may return 3 coordinates.
#'
#' @param h3_edge_index H3 edge index [character vector]
#' @inheritParams h3_to_geo_boundary
#'
#' @export
get_h3_unidirectional_edge_boundary <- function(h3_edge_index, format_as_geojson = TRUE) {
  res <- h3js_map("getH3UnidirectionalEdgeBoundary", h3_edge_index, format_as_geojson)
  if (!is.matrix(res)) res %<>% purrr::array_tree(1)

  if (format_as_geojson) res %<>% h3forr_class(pkg_env$h3forr_classes$lat_lng)

  res
}
