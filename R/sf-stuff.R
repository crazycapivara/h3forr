# TODO: obsolete, remove it!

h3_as_sf <- function(data) {
  features <- lapply(1:dim(data)[3], function(i) {
    list(data[, , i]) %>%
      sf::st_polygon()
  })
  sf::st_sfc(features, crs = 4326) %>%
    sf::st_sf()
}

## NEW
features_to_sf <- function(features) {
  sf::st_sfc(features, crs = 4326) %>% sf::st_sf()
}

#' Parse geo boundary array to sf object
#'
#' @param obj geo boundary array
#'
#' @name geo_boundary_to_sf
#' @export
geo_boundary_to_sf <- function(obj) {
  if (!any(class(obj) == "lng_lat_closed")) {
    stop("only closed loops of the form [lng, lat] are supported")
  }

  UseMethod("geo_boundary_to_sf")
}

#' @name geo_boundary_to_sf
#' @export
geo_boundary_to_sf.default <- function(obj) {
  sf::st_polygon(list(obj)) %>% features_to_sf()
}

#' @name geo_boundary_to_sf
#' @export
geo_boundary_to_sf.list <- function(obj) {
  lapply(obj, function(item) {
    sf::st_polygon(list(item))
  }) %>%
    features_to_sf()
}
