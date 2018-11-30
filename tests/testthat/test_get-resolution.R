context("checks")

test_that("h3-index-resolution", {
  # Prepare
  indexes <- get_sample_h3_indexes()

  # Act
  index_resolution <- h3_get_resolution(indexes)

  # Assert
  expect_length(index_resolution, 7)
  expect_is(index_resolution, "integer")
  expect_equal(index_resolution[1], 7)
})
