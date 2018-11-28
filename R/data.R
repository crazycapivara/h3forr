#' @importFrom tibble tibble
NULL

#' Persons in manhattan
#'
#' @format a tibble with 13987 rows and 3 variables:
#' \describe{
#'   \item{lng}{longitude}
#'   \item{lat}{latitude}
#'   \item{sex}{1: male, 2: female}
#' }
#'
#' @source \url{https://raw.githubusercontent.com/uber-common/deck.gl-data/master/examples/scatterplot/manhattan.json}
"manhattan"

#' greater manchester
#'
#' Coordinates describing the polygon of greater manchester
#'
#'@format a matrix with 216 rows and 2 columns:
#' \describe{
#'   \item{lng}{longitude}
#'   \item{lat}{latitude}
#' }
#'
#' @source \url{http://download.geofabrik.de/europe/great-britain/england/greater-manchester.poly}
"greater_manchester"

#' road safety greater manchester
#'
#' Personal injury road accidents in greater manchester from 1979
#'
#' @format a matrix with 3110 rows and 2 columns:
#' \describe{
#'   \item{lat}{latitude}
#'   \item{lng}{longitude}
#' }
#'
#' @source \url{https://raw.githubusercontent.com/uber-common/deck.gl-data/master/examples/3d-heatmap/heatmap-data.csv}
"road_safety_greater_manchester"
