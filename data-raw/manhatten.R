library(jsonlite)
library(tibble)

data_url <- paste0(
  "https://raw.githubusercontent.com/",
  "uber-common/deck.gl-data/",
  "master/examples/scatterplot/manhattan.json"
)

manhattan <- data_url %>%
  read_json(simplifyVector = TRUE) %>%
  as_tibble()

names(manhattan) <- c("lng", "lat", "sex")
# manhattan <- as.matrix(manhattan)
