context("geo-boundary-to-sf")

test_that("Single matrix", {
  # Prepare
  h3_index <- get_sample_h3_index()

  # Act
  polygon <- h3_to_geo_boundary(h3_index) %>% geo_boundary_to_sf()

  # Assert
  expect_is(polygon, "sf")
  expect_equal(sf::st_crs(polygon)$epsg, 4326)
  expect_equal(nrow(polygon), 1)
})

test_that("Multiple matrices", {
  # Prepare
  h3_indexes <- get_sample_h3_index() %>%
    k_ring()

  # Act
  polygons <- h3_to_geo_boundary(h3_indexes) %>% geo_boundary_to_sf()

  # Assert
  expect_is(polygons, "sf")
  expect_equal(sf::st_crs(polygons)$epsg, 4326)
  expect_equal(nrow(polygons), 7)
  # expect_equal(sf::st_geometry_type(polygons), "POLYGON")
})
