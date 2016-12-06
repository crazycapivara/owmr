context("weather data from stations")

load("data/stations_data.rda")

test_that("check number of stations", {
  expect_equal(nrow(stations_data), 15)
})

test_that("check data type of parsed response", {
  expect_is(stations_data, "data.frame")
})
