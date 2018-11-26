context("polyfill")

test_that("matrix and data frame", {
  # Prepare
  polygon <- greater_manchester
  resolution <- 5

  # Act
  h3_indexes <- polyfill(polygon, resolution)
  h3_indexes2 <- polyfill(as.data.frame(polygon), resolution)

  # Assert
  expect_length(h3_indexes, 4)
  expect_is(h3_indexes, "character")
  expect_equal(h3_indexes, h3_indexes2)
})
