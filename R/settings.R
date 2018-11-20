pkg_env <- new.env()

use_h3js <- function() {
  pkg_env$ctx <- V8::v8()
  system.file("js/h3-bundle.js", package = "h3forr") %>%
    pkg_env$ctx$source()
}

.onLoad <- function(libname, pkgname) {
  use_h3js()
}

# TODO: rename to 'h3js'
h3js_call <- function(func_name, ...) {
  pkg_env$ctx$call(func_name, ...)
}

h3js_map <- function(func_name, data, ...) {
  pkg_env$ctx$call("vectorize", func_name, data, list(...))
}

h3forr_class <- function(obj, class_name) {
  structure(obj, class = c(class(obj), class_name))
}
