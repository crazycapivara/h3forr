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
