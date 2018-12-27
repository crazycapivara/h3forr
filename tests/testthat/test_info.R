context("info functions")

test_that("count hexagons in the world", {
  # Prepare
  resolutions <- 0:4

  # Act
  count <- num_hexagons(resolutions)

  # Assert
  expect_equal(count, c(122, 842, 5882, 41162, 288122))
})

test_that("avg edge length", {
  # Prepare
  resolutions <- 10:13

  # Act
  avg_edge_length <- edge_length(resolutions) %>%
    round()

  # Assert
  expect_equal(avg_edge_length, c(66, 25, 9, 4))
  expect_length(avg_edge_length, 4)
})

test_that("hexagon area", {
  # Prepare
  resolutions <- 10:12
  unit <- "m2"

  # Act
  avg_hex_area <- hex_area(resolutions, unit) %>%
    round()

  # Assert
  expect_equal(avg_hex_area, c(15048, 2150, 307))
  expect_length(avg_hex_area, 3)
})
