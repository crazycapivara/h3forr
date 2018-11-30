context("h3-to-geo")

test_that("Single index", {
  # Prepare
  index <- get_sample_h3_index()

  # Act
  coords <- h3_to_geo(index)

  # Assert
  expect_is(coords, "numeric")
  expect_length(coords, 2)
  expect_gt(coords[1], 37)
  expect_lt(coords[2], -122)
})

test_that("Multiple indexes", {
  # Prepare
  indexes <- get_sample_h3_indexes()

  # Act
  coords <- h3_to_geo(indexes)

  # Assert
  expect_length(coords, 14)
  expect_is(coords, "matrix")
})
