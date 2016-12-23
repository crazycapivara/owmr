context("parse columns")

test_that("apply funcs to columns", {
  # when
  df <- data.frame(x = 1:5, y = 11:15, z = "OK")
  fx <- function(x) x * 2
  fy <- function(x) x - 1
  # then
  result <- parse_columns(df, list(x = fx, y = fy))
  expected_x <- seq(2, 10, 2)
  expected_y <- 10:14
  # ---
  expect_equal(result$x, expected_x)
  expect_equal(result$y, expected_y)
})
