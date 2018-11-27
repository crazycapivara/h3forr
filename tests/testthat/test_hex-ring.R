context("hex-ring")

test_that("Single center", {
  # Prepare
  h3_index <- get_sample_coords() %>% geo_to_h3()
  distance <- 2

  # Act
  h3_indexes <- hex_ring(h3_index, distance)

  # Assert
  expect_length(h3_indexes, 12)
  expect_is(h3_indexes, "character")
})

