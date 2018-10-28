context("current weather data")

# prepare
current <- readRDS("data/current.rds")

test_that("check longitude and latidude", {
  # act
  coords <- current$coord %>% unlist()

  # assert
  expect_equal(coords, c(lon = 9.48, lat = 51.31))
  expect_equal(current$coord$lon, 9.48)
  expect_equal(current$coord$lat, 51.31)
})

test_that("check data type", {
  # assert
  expect_is(current$weather, "data.frame")
})

test_that("check city id", {
  # act
  city_id <- with(owm_cities, owm_cities[nm == "Kassel", ]$id)

  # assert
  expect_equal(current$id, city_id)
})

test_that("parse to tibble", {
  # act
  data <- current %>% owmr_as_tibble()
  first_columns <- names(data)[1:6]
  weather <- data[startsWith(names(data), "weather")]

  # assert
  first_columns_expected <- c(
    "dt_txt", "temp", "pressure", "humidity", "temp_min", "temp_max"
  )

  expect_is(data, "tbl")
  expect_equal(first_columns, first_columns_expected)
  expect_length(weather, 4)
})
