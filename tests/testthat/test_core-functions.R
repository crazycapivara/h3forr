context("core-functions")

test_that("geo to h3: single point", {
  # Prepare
  coords <- get_sample_coords()

  # Act
  h3_index <- geo_to_h3(coords)

  # Assert
  expect_is(h3_index, "character")
  expect_length(h3_index, 1)
})

test_that("geo to h3: matrix, data frame, sf object", {
  # Prepare
  idx <- c("lat", "lng")
  coords <- greater_manchester[, idx]
  coords_df <- as.data.frame(coords)[, idx]
  resolution <- 7

  # Act
  h3_indexes <- geo_to_h3(coords, resolution)
  h3_indexes2 <- geo_to_h3(coords_df, resolution)
  h3_indexes3 <- sf::st_as_sf(coords_df, coords = c("lng", "lat"), crs = 4326) %>%
    geo_to_h3(resolution)

  # Assert
  expect_is(h3_indexes, "character")
  expect_length(h3_indexes, 216)
  expect_equal(h3_indexes, h3_indexes2)
  expect_equal(h3_indexes, h3_indexes3)
})
