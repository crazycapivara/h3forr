buffer_points <- function(points, res = 7, radius = 1, f = NULL) {
  if(is.null(f)) f <- function(radius, distance) 1 - distance * 1 / (1 + radius)

  geo_to_h3(points, res) %>%
    k_ring_distances(radius) %>%
    purrr::reduce(rbind) %>%
    dplyr::mutate(weight = f(radius, distance)) %>%
    dplyr::group_by(h3_index) %>%
    dplyr::summarise(weight = sum(weight)) %>%
    dplyr::mutate(norm = scales::rescale(weight, c(0, 1)))
}
