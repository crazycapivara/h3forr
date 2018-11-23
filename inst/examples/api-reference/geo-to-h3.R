coords <- c(37.3615593, -122.0553238)
geo_to_h3(coords, 7)

geo_to_h3(quakes[1:3, c("lat", "long")], res = 5)
