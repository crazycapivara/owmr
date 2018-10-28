context("current weather data for multiple cities")

# prepare
current_multiple <- readRDS("data/current_multiple.rds")

test_that("check number of cities", {
  # assert
  expect_equal(nrow(current_multiple$list), 3)
  expect_equal(current_multiple$cnt, 3)
})

test_that("check city ids", {
  # assert
  city_ids_expected <- c(2831088, 2847639, 2873291)

  expect_equal(current_multiple$list$id, city_ids_expected)
})

test_that("class", {
  # assert
  expect_equal(class(current_multiple), c("list", "owmr_group"))
})

test_that("parse response to tibble", {
  # act
  data <- current_multiple %>%
    owmr_as_tibble()
  idx_weather_description <- which(names(data) == "weather_description")
  contains_dt_txt <- "dt_txt" %in% names(data)

  # assert
  expect_equal(idx_weather_description, 9)
  expect_true(contains_dt_txt)
})
