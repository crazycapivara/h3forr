context("hexbins")

test_that("get hexbins", {
  # Prepare
  sample_data <- road_safety_greater_manchester
  resolution <- 6

  # Act
  result <- hexbins(sample_data, res = resolution)

  # Assert
  expect_length(result, 2)
  expect_equal(names(result), c("hexagons", "data"))
  expect_length(result$hexagons$h3_index, 52)
  expect_is(result$hexagons, "sf")
  expect_is(result$data, "sf")
  expect_equal(result$hexagons$count[1:3], c(3, 3, 29))
})
