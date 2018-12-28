#' Compact a set of hexagons of the same resolution into a set of hexagons
#' across multiple levels that represents the same area
#'
#' @inheritParams h3_is_valid
#'
#' @return character vector of H3 indexes
#'
#' @example inst/examples/api-reference/un-compact.R
#'
#' @export
compact <- function(h3_index) {
  h3js("compact", h3_index)
}

#' Uncompact a compacted set of hexagons to hexagons of the same resolution
#'
#' @inheritParams h3_is_valid
#' @param resolution resolution to uncompact to; number between 0 and 15
#'
#' @seealso \code{\link{compact}}
#'
#' @return character vector of H3 indexes;
#' throws an error if an invalid resolution is supplied
#'
#' @export
uncompact <- function(h3_index, res = 7) {
  h3js("uncompact", h3_index, res)
}
