pkg_env <- new.env()

pkg_env$h3forr_classes <- list(
  lat_lng = "lat_lng",
  lat_lng_closed = "lat_lng_closed"
)

use_h3js <- function(pkgname) {
  pkg_env$ctx <- V8::v8()
  system.file("js/h3-bundle.js", package = pkgname) %>%
    pkg_env$ctx$source()
}

.onLoad <- function(libname, pkgname) {
  use_h3js(pkgname)
}

h3js <- function(func_name, ...) {
  paste0("h3.", func_name) %>%
    pkg_env$ctx$call(...)
}

h3js_map <- function(func_name, data, ...) {
  pkg_env$ctx$call("vectorize", func_name, data, list(...))
}

h3js_map2 <- function(func_name, data, ...) {
  pkg_env$ctx$call("vectorize2", func_name, data, list(...))
}

h3forr_class <- function(obj, class_name) {
  structure(obj, class = c(class(obj), class_name))
}
