#' Get sample [lat, lng] point
#'
#' @export
get_sample_coords <- function() {
  c(37.3615593, -122.0553238)
}

#' Get sample H3 index
#'
#' @export
get_sample_h3_index <- function() {
  get_sample_coords() %>% geo_to_h3()
}

#' Get sample H3 indexes
#'
#' @export
get_sample_h3_indexes <- function() {
  get_sample_h3_index() %>% k_ring()
}
