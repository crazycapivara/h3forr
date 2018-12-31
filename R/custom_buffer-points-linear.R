get_coords <- function(points) {
  UseMethod("get_coords")
}

get_coords.matrix <- function(points) {
  points
}

get_coords.data.frame <- function(points) {
  as.matrix(points)
}

get_coords.sf <- function(points) {
  sf::st_coordinates(points)[, c("Y", "X")]
}

#' Buffer points linear
#'
#' @param points matrix, data frame
#' or object of class \code{sf} with \code{POINT} geometry
#' @param radius number of rings (used as buffer around points)
#' @param res resolution of hexagons to return
#'
#' @example inst/examples/api-reference/buffer-points-linear.R
#'
#' @export
buffer_points_linear <- function(points, radius = 2, res = 8) {
  result <- js("utils.bufferPointsLinear", get_coords(points), radius, res) %>%
    tibble::as_tibble()
  result$norm <- scales::rescale(result$weight, c(0, 1))
  result
}

#' Count points in each hexagon for a given resolution
#'
#' @inheritParams buffer_points_linear
#'
#' @export
count_points <- function(points, res = 7) {
  js("utils.countPoints", get_coords(points), res)
}
