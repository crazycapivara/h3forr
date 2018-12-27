## TODO: move other core functions to this file

#' Check whether a given string represents a valid H3 index
#'
#' @param h3_index character vector representing H3 indexes
#'
#' @return boolean vector
#'
#' @export
h3_is_valid <- function(h3_index) {
  h3js_map("h3IsValid", h3_index)
}

#' Get the resolution of a given H3 index
#'
#' @inheritParams h3_is_valid
#'
#' @return numeric vector of resolutions
#'
#' @export
h3_get_resolution <- function(h3_index) {
  h3js_map("h3GetResolution", h3_index)
}

#' Check whether the given H3 index is a pentagon
#'
#' @inheritParams h3_is_valid
#'
#' @return boolean vector
#'
#' @export
### TODO: add test(s)
h3_is_pentagon <- function(h3_index) {
  h3js_map("h3IsPentagon", h3_index)
}

#' Check whether the given H3 index is in a Class III resolution
#'
#' Check whether the given H3 index is in a Class III resolution
#' (rotated versus the icosahedron and subject to shape distortion adding extra points
#' on icosahedron edges, making them not true hexagons).
#'
#' @inheritParams h3_is_valid
#'
#' @return boolean vector
#'
#' @export
### TODO: add test(s)
h3_is_res_class_iii <- function(h3_index) {
  h3js_map("h3IsResClassIII", h3_index)
}

#' Get the number of the base cell for a given H3 index
#'
#' @inheritParams h3_is_valid
#'
#' @return numeric vector representing indexes of the base cells (1 - 122)
#'
#' @export
### TODO: add test(s)
h3_get_base_cell <- function(h3_index) {
  h3js_map("h3GetBaseCell", h3_index) + 1
}
