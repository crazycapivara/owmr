context("current weather data")

current <- readRDS("data/current.rds")

test_that("check longitude and latidude", {
  coords <- current$coord %>% unlist()
  expect_equal(coords, c(lon = 9.48, lat = 51.31))
  expect_equal(current$coord$lon, 9.48)
  expect_equal(current$coord$lat, 51.31)
})

test_that("check data type", {
  expect_is(current$weather, "data.frame")
})

test_that("check city id", {
  city_id <- with(owm_cities, owm_cities[nm == "Kassel", ]$id)
  expect_equal(current$id, city_id)
})
