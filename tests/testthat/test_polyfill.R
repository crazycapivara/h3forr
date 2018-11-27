context("polyfill")

test_that("matrix and data frame", {
  # Prepare
  polygon <- greater_manchester
  resolution <- 5

  # Act
  h3_indexes <- polyfill(polygon, resolution)
  h3_indexes2 <- polyfill(as.data.frame(polygon), resolution)

  # Assert
  expect_length(h3_indexes, 4)
  expect_is(h3_indexes, "character")
  expect_equal(h3_indexes, h3_indexes2)
})

test_that("sf object", {
  # Prepare
  nc <- system.file("shape/nc.shp", package = "sf") %>%
    sf::st_read(quiet = TRUE)

  # Act
  h3_index_list <- polyfill(nc[1:2, ], 5)
  h3_indexes <- unlist(h3_index_list)
  h3_indexes2 <- polyfill(nc[1, ], 5)

  # Assert
  expect_is(h3_index_list, "list")
  expect_is(h3_indexes2, "character")
  expect_length(h3_indexes, 6)
  expect_equal(h3_index_list[[1]], h3_indexes2)
})
