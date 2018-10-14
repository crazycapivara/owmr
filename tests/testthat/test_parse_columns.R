context("parse columns")

test_that("apply funcs to columns", {
  # prepare
  df <- data.frame(x = 1:5, y = 11:15, z = "OK")
  fx <- function(x) x * 2
  fy <- function(x) x - 1

  # act
  result <- parse_columns(df, list(x = fx, y = fy))

  # assert
  x_expected <- seq(2, 10, 2)
  y_expected <- 10:14

  expect_equal(result$x, x_expected)
  expect_equal(result$y, y_expected)
})
