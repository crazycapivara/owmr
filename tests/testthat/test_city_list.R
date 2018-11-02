context("city list")

test_that("search by city name", {
  # prepare
  city <- "Kassel"

  # act
  result <- search_city_list(city)

  # assert
  country_code_expected <- "DE"

  expect_equal(result$countryCode, country_code_expected)
})

test_that("search by city name and country code", {
  # prepare
  city <- "^Malaga"
  country_code <- "ES"

  # act
  result <- search_city_list(city, country_code)

  # assert
  lng_expected <- -4.42034

  expect_equal(result$lon, lng_expected)
})
