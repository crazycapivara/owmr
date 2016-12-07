context("current weather data")

load("data/current_weather.rda")

test_that("check longitude and latidude", {
  coords <- current_weather$coord %>% unlist()
  expect_equal(coords, c(lon = 9.50, lat = 51.32))
  expect_equal(current_weather$coord$lon, 9.5)
  expect_equal(current_weather$coord$lat, 51.32)
})

test_that("check weather data type", {
  expect_is(current_weather$weather, "data.frame")
})

test_that("check city id", {
  city_id <- with(owm_cities, owm_cities[nm == "Kassel", ]$id)
  expect_equal(current_weather$id, city_id)
})
