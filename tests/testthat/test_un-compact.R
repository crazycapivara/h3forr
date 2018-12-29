context("un-compact")

test_that("compact", {
  # Prepare
  resolution <- 7
  h3_indexes <- polyfill(greater_manchester, resolution)

  # Act
  greater_manchester_compact <- compact(h3_indexes)
  resolutions <- h3_get_resolution(greater_manchester_compact) %>% unique()

  # Assert
  expect_length(greater_manchester_compact, 83)
  expect_equal(resolutions, c(7, 6, 5))
})

test_that("uncompact", {
  # Prepare

  # Act

  # Assert
})
