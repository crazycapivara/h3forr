context("get-parent")

test_that("Single index", {
  # Prepare
  index <- get_sample_h3_index()

  # Act
  parent_index <- h3_to_parent(index)

  # Assert
  expect_equal(parent_index, "86283472fffffff")
})
