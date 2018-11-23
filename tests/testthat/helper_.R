coords <- c(37.3615593, -122.0553238)

get_h3_index <- function() {
  geo_to_h3(coords, 7)
}

get_h3_indexes <- function() {
  k_ring(get_h3_index())
}
