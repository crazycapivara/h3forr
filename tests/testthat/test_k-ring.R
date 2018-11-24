context("k-ring")

test_that("single center", {
  # Prepare
  h3_index <- get_sample_h3_index()

  # Act
  neighbors <- k_ring(h3_index)

  # Assert
  expect_length(neighbors, 7)
  expect_is(neighbors, "character")
  expect_equal(neighbors[1], h3_index)
})

test_that("multiple centers", {
  # Prepare
  h3_indexes <- geo_to_h3(manhattan[1:2, c("lng", "lat")], 15)

  # Act
  neighbors <- k_ring(h3_indexes)

  # Assert
  expect_is(neighbors, "list")
  expect_length(neighbors, 2)
  expect_length(neighbors[[1]], 7)
  expect_is(neighbors[[2]], "character")
})
