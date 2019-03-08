sample_data <- lapply(1:100, function(i) road_safety_greater_manchester) %>%
  do.call(rbind, .)

f1 <- function() {
  geo_to_h3(sample_data, 8) %>%
    table() %>%
    tibble::as_tibble(n = "count")
}

f2 <- function() {
  count_points(sample_data, 8) %>%
    tibble::as_tibble()
}

microbenchmark::microbenchmark(
  r = f1(),
  js = f2(),
  times = 3
)
