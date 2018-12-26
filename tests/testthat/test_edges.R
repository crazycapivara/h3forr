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

test_that("edges from hexagon", {
  # Prepare
  h3_index <- get_sample_h3_index()
  h3_indexes <- get_sample_h3_indexes()

  # Act
  edges <- get_h3_unidirectional_edges_from_hexagon(h3_index)
  multiple_edge_objects <- get_h3_unidirectional_edges_from_hexagon(h3_indexes)

  # Assert
  expect_length(edges, 6)
  expect_is(edges, "character")
  expect_length(multiple_edge_objects, 7)
  expect_is(multiple_edge_objects, "list")
})

test_that("unidirectional edge boundary", {
  # Prepare
  h3_edge_index <- get_sample_h3_edge_index()
  count <- 3
  h3_edge_indexes <- rep(h3_edge_index, count)

  # Act
  edge_boundary <- get_h3_unidirectional_edge_boundary(h3_edge_index)
  multiple_edge_boundaries <- get_h3_unidirectional_edge_boundary(h3_edge_indexes)

  # Assert
  expect_is(edge_boundary, "matrix")
  expect_is(multiple_edge_boundaries, "list")
  expect_is(multiple_edge_boundaries[[1]], "matrix")
  expect_length(multiple_edge_boundaries, 3)
  expect_equal(dim(multiple_edge_boundaries[[1]]), c(2, 2))
})
