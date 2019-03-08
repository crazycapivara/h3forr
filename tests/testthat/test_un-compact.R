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
  resolution <- 7
  h3_indexes <- get_sample_h3_index() %>% k_ring(4)
  h3_indexes_compact <- compact(h3_indexes)

  # Act
  h3_indexes_uncompact <- uncompact(h3_indexes_compact, res = resolution)
  resolutions <- h3_get_resolution(h3_indexes_uncompact) %>% unique()

  # Assert
  expect_length(h3_indexes_uncompact, 61)
  expect_equal(resolutions, 7)
})
