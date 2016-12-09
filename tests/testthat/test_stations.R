context("current weather data from multiple stations")

stations_multiple <- readRDS("data/stations_multiple.rds")

test_that("check number of stations", {
  expect_equal(nrow(stations_multiple), 15)
})

test_that("check data type", {
  expect_is(stations_multiple, "data.frame")
})
