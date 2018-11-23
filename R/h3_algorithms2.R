#' Get the parent of the given hexagon at a particular resolution
#'
#' @param h3_index H3 index [vector]
#' @param res resolution (if \code{NULL} the resolution will be set to
#'    \code{h3_get_resolution(h3_index[1]) - 1}
#'
#' @example inst/examples/api-reference/h3-to-parent.R
#'
#' @export
h3_to_parent <- function(h3_index, res = NULL) {
  if (is.null(res)) res <- h3_get_resolution(h3_index[1]) - 1

  h3js_map("h3ToParent", h3_index, res)
}

#' Get the children/descendents of the given hexagon at a particular resolution
#'
#' @inheritParams h3_to_parent
#' @param res resolution (if \code{NULL} the resolution will be set to
#'    \code{h3_get_resolution(h3_index[1]) + 1}
#'
#' @example inst/examples/api-reference/h3-to-children.R
#'
#' @export
h3_to_children <- function(h3_index, res = NULL) {
  if (is.null(res)) res <- h3_get_resolution(h3_index[1]) + 1

  res <- h3js_map("h3ToChildren", h3_index, res)
  if (is.array(res)) res %<>% purrr::array_tree(1)

  res
}
