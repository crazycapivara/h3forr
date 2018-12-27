context("checks")

test_that("is-valid-h3-index", {
  # Prepare
  indexes <- get_sample_h3_indexes() -> indexes2
  indexes2[2] <- get_sample_h3_edge_index()

  # Act
  indexes_are_valid <- h3_is_valid(indexes)
  index_is_valid <- h3_is_valid(indexes2)[2]

  # Assert
  expect_true(all(indexes_are_valid))
  expect_false(index_is_valid)
})
