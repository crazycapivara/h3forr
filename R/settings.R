pkg_env <- new.env()

use_h3js <- function() {
  pkg_env$ctx <- V8::v8()
  system.file("js/h3-bundle.js", package = "h3forr") %>%
    pkg_env$ctx$source()
}

h3js_call <- function(func_name, ...) {
  pkg_env$ctx$call(func_name, ...)
}
