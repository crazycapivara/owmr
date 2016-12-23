mock_httr_GET <- function(...) {
  readRDS("data/response-stations_multiple.rds")
}

stations_multiple <- readRDS("data/stations_multiple.rds")

context("current weather data from multiple stations")

test_that("check number of stations", {
  expect_equal(nrow(stations_multiple), 15)
})

test_that("check data type", {
  expect_is(stations_multiple, "data.frame")
})

test_that("mock stations", {
  with_mock(
    `httr::GET` = mock_httr_GET, {
      # when
      owmr_settings("my_api_key")
      lat <- 51.31667
      lon <- 9.5
      # then
      result <- find_stations_by_geo_point(lat, lon)
      # ---
      owmr_settings(NULL) # reset api key
      expect_is(result, "data.frame")
    }
  )
})
