#' Get the hexagon containing a lat,lon point
#'
#' @param lat latidude
#' @param lng longitude
#' @param res resolution of hexagons to return
#'
#' @export
geo_to_h3 <- function(lat, lng, res) {
  h3js_call("h3.geoToH3", lat, lng, res)
}

geo_to_h3_map <- function(data, lat = "lat", lng = "lng", res = 7) {
  data <- data[c(lat, lng)]
  data$res <- res
  h3js_map("geoToH3", as.matrix(data))
}
