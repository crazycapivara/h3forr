% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/h3_edges.R
\name{h3_indexes_are_neighbors}
\alias{h3_indexes_are_neighbors}
\title{Check whether two H3 (hexagon) indexes are neighbors (share an edge)}
\usage{
h3_indexes_are_neighbors(origin_h3_index, destination_h3_index)
}
\arguments{
\item{origin_h3_index}{H3 index (origin); character vector}

\item{destination_h3_index}{H3 index (destination); character (single value)}
}
\value{
boolean vector
}
\description{
Check whether two H3 (hexagon) indexes are neighbors (share an edge)
}
\examples{
coords <- c(37.3615593, -122.0553238)
h3_index <- geo_to_h3(coords)
neighbors <- k_ring(h3_index, 2)

h3_indexes_are_neighbors(neighbors, h3_index)
}
