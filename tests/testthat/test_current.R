context("current weather data")

# load("data/current_weather.rda")
current <- readRDS("data/current.rds")

test_that("check longitude and latidude", {
  coords <- current$coord %>% unlist()
  expect_equal(coords, c(lon = 9.50, lat = 51.32))
  expect_equal(current$coord$lon, 9.5)
  expect_equal(current$coord$lat, 51.32)
})

test_that("check data type", {
  expect_is(current$weather, "data.frame")
})

test_that("check city id", {
  city_id <- with(owm_cities, owm_cities[nm == "Kassel", ]$id)
  expect_equal(current$id, city_id)
})
