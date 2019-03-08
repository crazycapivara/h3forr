### workaround because 'cbind' does some weird things for 'sf' objects
### and 'sf:::cbind.sf' is not exported
### 'dplyr::bind_cols' works but I do not want to have a 'dplyr' dependency
### at the moment
cbind_sf <- function(sf_obj, df) {
  sf_obj[, colnames(df)] <- df
  sf_obj
}

### TODO: export?
count_h3 <- function(h3_index) {
  h3_index_tbl <- table(h3_index) %>%
    tibble::as_tibble(n = "count")
  hexagons <- h3_to_geo_boundary(h3_index_tbl$h3_index) %>%
    geo_boundary_to_sf()
  # sf:::cbind.sf(hexagons, h3_index_tbl)
  cbind_sf(hexagons, h3_index_tbl)
}

#' Get hexbins for given points and resolution
#'
#' @inheritParams geo_to_h3
#' @param data matrix, data frame (with latidude and longitude columns)
#' or object of class \code{sf} (\code{POINT} geometry)
#' @param ... ignored
#'
#' @example inst/examples/api-reference/hexbins.R
#'
#' @name hexbins
#' @export
hexbins <- function(data, res = 7, ...) {
  UseMethod("hexbins")
}

#' @name hexbins
#' @export
hexbins.sf <- function(data, res = 7, ...) {
  data$h3_index <- geo_to_h3(data, res)
  hexagons <- count_h3(data$h3_index)
  list(hexagons = hexagons, data = data) %>%
    h3forr_class("h3forr_hexbins")
}

#' @param lat name of latitude column
#' @param lng name of longitude column
#'
#' @name hexbins
#' @export
hexbins.data.frame <- function(data, res = 7, lat = "lat", lng = "lng", ...) {
  sf::st_as_sf(data, coords = c(lng, lat), crs = 4326) %>%
    hexbins(res)
}

#' @name hexbins
#' @export
hexbins.matrix <- function(data, res = 7, lat = "lat", lng = "lng", ...) {
  as.data.frame(data) %>%
    hexbins(res, lat = lat, lng = lng)
}

#' @export
`[.h3forr_hexbins` <- function(x, i, ...) {
  # x$data[i, ...]
  if (inherits(i, "character")) {
    return(x$data[x$data$h3_index %in% i, ])
  }
  x$data[x$data$h3_index %in% x$hexagons$h3_index[i], ]
}
