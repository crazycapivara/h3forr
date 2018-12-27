context("get-children")

test_that("Single index", {
  # Prepare
  index <- get_sample_h3_index()

  # Act
  children_indexes <- h3_to_children(index)

  # Assert
  expect_length(children_indexes, 7)
})

test_that("Multiple indexes", {
  # Prepare
  indexes <- get_sample_h3_indexes()

  # Act
  children_indexes <- h3_to_children(indexes)

  # Assert
  expect_is(children_indexes, "list")
  expect_length(children_indexes, 7)
})
