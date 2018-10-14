context("render operator")

test_that("data frame input", {
  # prepare
  df <- iris[1:5, ]

  # act
  result <- "{{Species}}: {{Sepal_Length}}" %$$% df

  # assert
  length_expected <- 5
  values_expected <- c("setosa: 5.1", "setosa: 4.9")

  expect_length(result, length_expected)
  expect_equal(result[1:2], values_expected)
})

test_that("list input", {
  # prepare
  l <- list(name = "stef", country = "DE")

  # act
  result <- "{{name}} lives in {{country}}" %$$% l

  # assert
  result_expected <- "stef lives in DE"

  expect_equal(result, result_expected)
})
