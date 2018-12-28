#' Get sample [lat, lng] point
#'
#' @export
get_sample_coords <- function() {
  c(37.3615593, -122.0553238)
}

#' Get sample H3 index
#'
#' @export
get_sample_h3_index <- function() {
  get_sample_coords() %>% geo_to_h3()
}

#' Get sample H3 indexes
#'
#' @export
get_sample_h3_indexes <- function() {
  get_sample_h3_index() %>% k_ring()
}

#' Get sample H3 edge index
#'
#' @export
get_sample_h3_edge_index <- function() {
  indexes <- get_sample_h3_indexes()
  get_h3_unidirectional_edge(indexes[1], indexes[2])
}

count_h3_obs <- function(h3_index, to_sf = TRUE) {
  freq_tbl <- table(h3_index) %>%
    # as.data.frame(responseName = "count") %>%
    tibble::as_tibble()
  if (!to_sf) return(freq_tbl)

  geo <- h3_to_geo_boundary(freq_tbl$h3_index) %>%
    geo_boundary_to_sf()
  geo$count <- freq_tbl$n
  geo
}

### same as 'tibble::enframe(l, "idx", "h3_index") %>% tidyr::unnest()'
list_to_df <- function(x, key = "idx", value = "value") {
  result <- lapply(1:length(x), function(i) {
    data.frame(key = i, value = x[[i]])
  })
  df <- do.call(rbind, result)
  names(df) <- c(key, value)
  df
}

# ---------
count_h3 <- function(h3_indexes) {
  column_names <- c("h3_index", "count")

  h3_index_tbl <- table(h3_indexes) %>%
    tibble::as_tibble()
  colnames(h3_index_tbl) <- column_names

  hexagons <- h3_to_geo_boundary(h3_index_tbl$h3_index) %>%
    geo_boundary_to_sf()
  hexagons[, column_names] <- h3_index_tbl

  hexagons
}

#' Get hexbins for given points and resolution
#'
#' @inheritParams geo_to_h3
#' @param data matrix, data frame (with latidude and longitude columns)
#' or object of class \code{sf} (\code{POINT} geometry)
#' @param ... ignored
#'
#' @name hexbins
#' @export
hexbins <- function(data, res = 7, ...) {
  UseMethod("hexbins")
}

#' @name hexbins
#' @export
hexbins.sf <- function(data, res = 7, ...) {
  h3_indexes <- geo_to_h3(data, res)
  data$h3_index <- h3_indexes

  hexagons <- count_h3(h3_indexes)

  list(
    hexagons = hexagons,
    data = data
  )
}

#' @param lat name of latitude column
#' @param lng name of longitude column
#'
#' @name hexbins
#' @export
hexbins.data.frame <- function(data, res = 7, ..., lat = "lat", lng = "lng") {
  sf::st_as_sf(data, coords = c(lng, lat), crs = 4326) %>%
    hexbins(res)
}
#' Get hexbins
#'
#' @inheritParams geo_to_h3
#' @param data matrix, data frame or \code{sf} object
#' @param lat name of latitude column if matrix or data frame is supplied
#' @param lng name of longitude column if matrix or data frame is supplied
#'
#' @export
hexbins_legacy <- function(data, res = 7, lat = "lat", lng = "lng") {
  if (inherits(data, "matrix")) data %<>% as.data.frame()

  if (inherits(data, "data.frame")) {
    data %<>% sf::st_as_sf(coords = c(lng, lat), crs = 4326)
  }

  h3_indexes <- geo_to_h3(data, res)
  data$h3_index <- h3_indexes

  h3_index_tbl <- table(h3_indexes) %>%
    tibble::as_tibble()
  colnames(h3_index_tbl) <- c("h3_index", "count")

  hexagons <- h3_to_geo_boundary(h3_index_tbl$h3_index) %>%
    geo_boundary_to_sf()

  hexagons[, c("h3_index", "count")] <- h3_index_tbl

  list(
    hexagons = hexagons,
    data = data
  )
}
