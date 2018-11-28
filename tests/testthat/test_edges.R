context("edges")

test_that("valid, origin and destination", {
  # Prepare
  h3_indexes <- get_h3_indexes()
  origin <- h3_indexes[1]
  destination <- h3_indexes[2]

  # Act
  h3_edge_index <- get_h3_unidirectional_edge(origin, destination)
  index_is_valid <- h3_unidirectional_edge_is_valid(h3_edge_index)
  this_origin <- get_origin_h3_index_from_unidirectional_edge(h3_edge_index)
  this_destination <- get_destination_h3_index_from_unidirectional_edge(h3_edge_index)
  index_pair <- get_h3_indexes_from_unidirectional_edge(h3_edge_index)

  # Assert
  expect_true(index_is_valid)
  expect_equal(this_origin, origin)
  expect_equal(this_destination, destination)
  expect_equal(index_pair, c(origin, destination))
})
