### TODO: export?
count_h3 <- function(h3_indexes) {
  column_names <- c("h3_index", "count")

  h3_index_tbl <- table(h3_indexes) %>%
    tibble::as_tibble()
  colnames(h3_index_tbl) <- column_names

  hexagons <- h3_to_geo_boundary(h3_index_tbl$h3_index) %>%
    geo_boundary_to_sf()
  hexagons[, column_names] <- h3_index_tbl

  hexagons
}

#' Get hexbins for given points and resolution
#'
#' @inheritParams geo_to_h3
#' @param data matrix, data frame (with latidude and longitude columns)
#' or object of class \code{sf} (\code{POINT} geometry)
#' @param ... ignored
#'
#' @name hexbins
#' @export
hexbins <- function(data, res = 7, ...) {
  UseMethod("hexbins")
}

#' @name hexbins
#' @export
hexbins.sf <- function(data, res = 7, ...) {
  h3_indexes <- geo_to_h3(data, res)
  data$h3_index <- h3_indexes

  hexagons <- count_h3(h3_indexes)

  list(
    hexagons = hexagons,
    data = data
  )
}

#' @param lat name of latitude column
#' @param lng name of longitude column
#'
#' @name hexbins
#' @export
hexbins.data.frame <- function(data, res = 7, ..., lat = "lat", lng = "lng") {
  sf::st_as_sf(data, coords = c(lng, lat), crs = 4326) %>%
    hexbins(res)
}

#' @name hexbins
#' @export
hexbins.matrix <- function(data, res = 7, ..., lat = "lat", lng = "lng") {
  as.data.frame(data) %>%
    hexbins(res, lat = lat, lng = lng)
}
