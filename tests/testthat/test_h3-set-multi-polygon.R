context("set multi polygon")

test_that("merge k-ring", {
  # Prepare
  h3_indexes <- get_sample_h3_index() %>% k_ring()

  # Act
  coords <- h3_set_to_multi_polygon(h3_indexes)
  polygon <- geo_boundary_to_sf(coords)

  # Assert
  expect_is(coords, c("matrix", pkg_env$h3forr_classes$lat_lng_closed))
  expect_is(polygon, "sf")
})
