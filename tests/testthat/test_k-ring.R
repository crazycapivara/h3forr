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

test_that("ordered by distance: single center", {
  # Prepare
  origin <- get_sample_h3_index()

  # Act
  neighbors <- k_ring_distances(origin, 2)

  # Assert
  expect_is(neighbors, "data.frame")
  expect_true(min(neighbors$distance) == 0)
  expect_true(max(neighbors$distance) == 2)
  expect_length(neighbors$h3_index, 19)
  # expect_is(neighbors, "list")
  # expect_is(neighbors[[1]], "character")
  # expect_length(neighbors, 3)
  # expect_equal(neighbors[[1]], origin)
})

test_that("ordered by distance: multiple centers", {
  # Prepare
  origins <- get_sample_h3_indexes()

  # Act
  neighbors <- k_ring_distances(origins, 2)

  # Assert
  expect_is(neighbors, "list")
  expect_is(neighbors[[1]], "data.frame")
  expect_length(neighbors, 7)
  expect_equal(neighbors[[1]]$h3_index[1], origins[1])
})
