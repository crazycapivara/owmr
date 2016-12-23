mock_httr_GET <- function(...) {
  readRDS("data/response-current.rds")
}

context("mock httr::GET current")

test_that("current weather data", {
  with_mock(
    `httr::GET` = mock_httr_GET, {
      # when
      owmr_settings("my_api_key")
      city <- "Kassel"
      # then
      expected_name <- "Kassel"
      expected_country <- "DE"
      expected_nitems <- 12 # number of items
      # -----
      result <- get_current(city)
      owmr_settings(NULL)
      expect_equal(result$name, expected_name)
      expect_equal(result$sys$country, expected_country)
      expect_equal(length(result), expected_nitems)
    }
  )
})
