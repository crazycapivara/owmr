context("tidy up data")

test_that("remove prefix", {
  # prepare
  current_multiple <- readRDS("data/current_multiple.rds")

  # act
  data <- remove_prefix(current_multiple$list, c("main", "sys"))
  contains_temp_min <- "temp_min" %in% names(data)
  contains_sunrise <- "sunrise" %in% names(data)

  # assert
  expect_true(contains_temp_min)
  expect_true(contains_sunrise)
})

test_that("use underscore", {
  # prepare
  data <- iris[, 1:2]

  # act
  tidy_iris <- use_underscore(data)

  # assert
  names_expected <- c("Sepal_Length", "Sepal_Width")

  expect_equal(names(tidy_iris), names_expected)
})
