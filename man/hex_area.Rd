% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/h3_info.R
\name{hex_area}
\alias{hex_area}
\title{Get the average hexagon area at a given resolution}
\usage{
hex_area(res = 7, unit = "m2")
}
\arguments{
\item{res}{resolution; numeric vector with values between 0 and 15}

\item{unit}{unit, either \code{m2} or \code{km2}}
}
\value{
numeric vector
}
\description{
Get the average hexagon area at a given resolution
}
\examples{
hex_area(1:4, unit = "km2")

}
