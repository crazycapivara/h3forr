context("more info stuff")

test_that("distance", {
  # Prepare
  h3_index <- get_sample_h3_index()
  h3_indexes <- k_ring(h3_index, 3)
  count <- length(h3_indexes)

  # Act
  distances <- h3_distance(h3_indexes[2:count], h3_index)

  # Assert
  expect_length(distances, 36)
  expect_equal(distances[1:6], rep(1, 6))
  expect_equal(distances[7:18], rep(2, 12))
  expect_equal(distances[19:36], rep(3, 18))
})
