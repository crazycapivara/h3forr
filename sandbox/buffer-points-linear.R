### buffer points linear
library(sf)
library(purrr)
library(data.table)
library(scales)

bart_stations <- system.file("geojson/bart_stations.geojson", package = "h3forr") %>%
  st_read(quiet = TRUE)

radius <- 2

hex <- geo_to_h3(bart_stations, res = 8) %>%
  k_ring_distances(radius) %>%
  reduce(rbind) %>%
  as.data.table()

step <- 1 / (radius + 1)
hex$weight <- 1 - hex$distance * step
hex <- hex[, .(weight = sum(weight)), .(h3_index)]
hex$norm <- rescale(hex$weight, c(0, 1))

# as function
buffer_points <- function(points, .f, res = 8, radius = 2) {
  result <- geo_to_h3(points, res = res) %>%
    k_ring_distances(radius) %>%
    purrr::reduce(rbind) %>%
    data.table::as.data.table()
  result$weight <- .f(result$distance, radius)
  result <- result[, .(weight = sum(weight)), .(h3_index)]
  result$norm <- scales::rescale(result$weight, c(0, 1))
  # result[, norm := scales::rescale(weight, c(0, 1))]
  result
}

### this should already be done in k_ring_distancesm (done! see above)
x <- geo_to_h3(bart_stations, res = 8) %>%
  k_ring_distances(radius) %>%
  lapply(h3forr_unnest, name = "distance", value = "h3_index") %>%
  do.call(rbind, .) %>% as.data.table()
x$distance <- x$distance - 1

step <- 1 / (radius + 1)

x$weight <- 1 - x$distance * step
x <- x[, .(weight = sum(weight)), .(h3_index)]
# x[, weight := sum(weight), .(h3_index)]
x[, norm := scales::rescale(weight, c(0, 1))]


### old approach
layer <- list()

for (i in 1:nrow(x)) {
  row <- x[i, ]
  value <- layer[[row$h3_index]]
  layer[[row$h3_index]] <- ifelse(is.null(value), 0, value) + 1 - row$distance * step
}

result <- h3forr_unnest(layer, name = "h3_index", value = "weight")
result$norm <- scales::rescale(result$weight, c(0, 1))
