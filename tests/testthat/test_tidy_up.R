context("tidy up data")

test_that("remove prefix", {
  # when
  current_multiple <- readRDS("data/current_multiple.rds")$list %>%
    remove_prefix(c("main", "sys"))
  names_ <- names(current_multiple)
  # then
  contains_temp_min <- "temp_min" %in% names_
  contains_sunrise <- "sunrise" %in% names_
  expect_true(contains_temp_min)
  expect_true(contains_sunrise)
})

test_that("tidy up all", {
  # when
  current_multiple <- readRDS("data/current_multiple.rds") %>%
    tidy_up()
  names_ <- names(current_multiple$list)
  # then
  contains_weather_icon <- "weather_icon" %in% names_
  expect_true(contains_weather_icon)
})

test_that("use underscore", {
  # when
  tidy_iris <- use_underscore(iris[, 1:2])
  # then
  expected_names <- c("Sepal_Length", "Sepal_Width")
  # ---
  expect_equal(names(tidy_iris), expected_names)
})
