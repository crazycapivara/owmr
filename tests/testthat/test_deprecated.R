context("_DEPRECATED")

test_that("tidy up all", {
  # prepare
  current_multiple <- readRDS("data/current_multiple.rds")

  # act
  tidy_data <- tidy_up(current_multiple)
  contains_weather_icon <- "weather_icon" %in% names(tidy_data$list)

  # assert
  expect_true(contains_weather_icon)
})
