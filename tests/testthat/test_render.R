context("render operator")

test_that("data frame input", {
  # when
  df <- iris[1:5, ]
  result <- "{{Species}}: {{Sepal_Length}}" %$$%
    df
  # then
  expected_cnt <- 5
  expected_values <- c("setosa: 5.1", "setosa: 4.9")
  # -----
  expect_equal(length(result), expected_cnt)
  expect_equal(result[1:2], expected_values)
})

test_that("list input", {
  # when
  l <- list(name = "stef", country = "DE")
  result <- "{{name}} lives in {{country}}" %$$% l
  # then
  expected <- "stef lives in DE"
  # -----
  expect_equal(result, expected)
})
