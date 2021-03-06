% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/h3_un-compact.R
\name{compact}
\alias{compact}
\title{Compact a set of hexagons of the same resolution into a set of hexagons
across multiple levels that represents the same area}
\usage{
compact(h3_index)
}
\arguments{
\item{h3_index}{character vector representing H3 indexes}
}
\value{
character vector of H3 indexes
}
\description{
Compact a set of hexagons of the same resolution into a set of hexagons
across multiple levels that represents the same area
}
\examples{
library(sf)

# helper
plot_this <- function(h3_indexes, color = "blue", add = FALSE) {
  h3_to_geo_boundary(h3_indexes) \%>\%
    geo_boundary_to_sf() \%>\% st_geometry() \%>\%
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
}
