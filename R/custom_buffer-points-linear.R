get_coords <- function(points) {
  sf::st_coordinates(points)[, c("Y", "X")]
}

#' Buffer points linear
#'
#' @param points object of class \code{sf} with \code{POINT} geometry
#' @param radius number of rings (used as buffer around points)
#' @param res resollution of hexagons to return
#'
#' @example inst/examples/api-reference/buffer-points-linear.R
#'
#' @export
buffer_points_linear <- function(points, radius = 2, res = 8) {
  result <- pkg_env$ctx$call("utils.bufferPointsLinear", get_coords(points), radius, res) %>%
    tibble::as_tibble()
  result$norm <- scales::rescale(result$weight, c(0, 1))
  result
}
