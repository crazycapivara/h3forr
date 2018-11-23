geo_to_sf_ <- function(obj) {
  as.data.frame(obj) %>%
    sf::st_as_sf(coords = 2:1, crs = 4326)
}

#' Parse [lat, lng] points to sf object
#'
#' @param coords [lat, lng] points
#'
#' @name geo_to_sf
#' @export
geo_to_sf <- function(coords) {
  UseMethod("geo_to_sf", coords)
}

#' @name geo_to_sf
#' @export
geo_to_sf.matrix <- geo_to_sf_

#' @name geo_to_sf
#' @export
geo_to_sf.numeric <- function(coords) {
  matrix(coords, ncol = 2) %>%
    geo_to_sf_()
}

#' @name geo_to_sf
#' @export
geo_to_sf.list <- function(coords) {
  coords <- lapply(seq_along(coords), function(idx) {
    cbind(coords[[idx]], idx)
  })
  do.call(rbind, coords) %>%
    geo_to_sf_()
}
