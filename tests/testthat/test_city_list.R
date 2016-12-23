context("city list")

test_that("search by city name", {
  # when
  city <- "Kassel"
  # then
  result <- search_city_list(city)
  expected_country_code <- result$countryCode
  # ---
  expect_equal(expected_country_code, "DE")
})

test_that("search by city name and country code", {
  # when
  city <- "^Malaga"
  country_code <- "ES"
  # then
  result <- search_city_list(city, country_code)
  lng <- result$lon
  expected_lng <- -4.42034
  # ---
  expect_equal(lng, expected_lng)
})
