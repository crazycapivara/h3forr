### buffer points linear
library(sf)

bart_stations <- system.file("geojson/bart_stations.geojson", package = "h3forr") %>%
  st_read(quiet = TRUE)

radius <- 2

### this should already be done in k_ring_distances
x <- geo_to_h3(bart_stations, res = 8) %>%
  k_ring_distances(radius) %>%
  lapply(h3forr_unnest, name = "distance", value = "h3_index") %>%
  do.call(rbind, .)
x$distance <- x$distance - 1

step <- 1 / (radius + 1)

layer <- list()

for (i in 1:nrow(x)) {
  row <- x[i, ]
  value <- layer[[row$h3_index]]
  layer[[row$h3_index]] <- ifelse(is.null(value), 0, value) + 1 - row$distance * step
}

result <- h3forr_unnest(layer, name = "h3_index", value = "weight")
result$norm <- scales::rescale(result$weight, c(0, 1))
