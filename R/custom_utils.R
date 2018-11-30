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

#' Get sample H3 edge index
#'
#' @export
get_sample_h3_edge_index <- function() {
  indexes <- get_sample_h3_indexes()
  get_h3_unidirectional_edge(indexes[1], indexes[2])
}

count_h3 <- function(h3_index, to_sf = TRUE) {
  freq_tbl <- table(h3_index) %>%
    # as.data.frame(responseName = "count") %>%
    tibble::as_tibble()
  if (!to_sf) return(freq_tbl)

  geo <- h3_to_geo_boundary(freq_tbl$h3_index) %>%
    geo_boundary_to_sf()
  geo$count <- freq_tbl$n
  geo
}
