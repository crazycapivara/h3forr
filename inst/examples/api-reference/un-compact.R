# helper
plot_this <- function(h3_indexes, color = "blue", add = FALSE) {
  h3_to_geo_boundary(h3_indexes) %>%
    geo_boundary_to_sf() %>% st_geometry() %>%
    plot(col = color, add = add)
}

resolution <- 7
h3_indexes <- polyfill(greater_manchester, resolution)
plot_this(h3_indexes)

# compact
greater_manchester_compact <- compact(h3_indexes)
plot_this(greater_manchester_compact, color = "red", add = TRUE)

# uncompact
greater_manchester_uncompact <- uncompact(greater_manchester_compact, resolution)
sort(greater_manchester_uncompact) == sort(h3_indexes)

greater_manchester_uncompact2 <- uncompact(greater_manchester_compact, res = 8)
plot_this(greater_manchester_uncompact2)
