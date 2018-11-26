context("polyfill")

test_that("matrix", {
  # Prepare
  polygon <- greater_manchester
  resolution <- 5

  # Act
  h3_indexes <- polyfill(polygon, resolution)

  # Assert
  expect_length(h3_indexes, 4)
  expect_is(h3_indexes, "character")
})
