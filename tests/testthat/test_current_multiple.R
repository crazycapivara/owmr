context("current weather data for multiple cities")

res_multiple <- readRDS("data/current_weather_multiple.rds")

test_that("check number of cities", {
  expect_equal(nrow(res_multiple$list), 3)
  expect_equal(res_multiple$cnt, 3)
})

test_that("check city ids", {
  city_ids <- c(2831088, 2847639, 2873291)
  expect_equal(res_multiple$list$id, city_ids)
})
