context("geo-to-sf")

test_that("Single center point", {
  # Prepare
  h3_geo <- get_h3_index() %>% h3_to_geo()

  # Act
  sf_obj <- geo_to_sf(h3_geo)

  # Assert
  expect_is(sf_obj, "sf")
  expect_equal(dim(sf_obj), c(1, 1))
})

test_that("Multiple center points", {
  # Prepare
  h3_geo <- get_h3_indexes() %>% h3_to_geo()

  # Act
  sf_obj <- geo_to_sf(h3_geo)

  # Assert
  expect_is(sf_obj, "sf")
  expect_equal(dim(sf_obj), c(7, 1))
})

test_that("Boundary points (single hexagon)", {
  # Prepare
  h3_geo <- h3_to_geo_boundary(get_h3_index(), format_as_geojson = FALSE)

  # Act
  sf_obj <- geo_to_sf(h3_geo)

  # Assert
  expect_is(sf_obj, "sf")
  expect_equal(dim(sf_obj), c(6, 1))
})

test_that("Boundary points (multiple hexagons)", {
  # Prepare
  h3_geo <- h3_to_geo_boundary(get_h3_indexes(), format_as_geojson = FALSE)

  # Act
  sf_obj <- geo_to_sf(h3_geo)

  # Assert
  expect_is(sf_obj, "sf")
  expect_equal(dim(sf_obj), c(42, 2))
})
