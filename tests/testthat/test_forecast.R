mock_httr_GET <- function(...) {
  readRDS("data/response-forecast.rds")
}

context("mock httr::GET forecast")

test_that("forecast data", {
  with_mock(
    `httr::GET` = mock_httr_GET, {
      # when
      owmr_settings("my_api_key")
      city <- "London"
      # then
      result <- get_forecast(city)
      expected_country <- "GB"
      expected_ncols <- 16
      # ---
      owmr_settings(NULL) # reset api key
      expect_equal(result$city$country, expected_country)
      expect_equal(ncol(result$list), expected_ncols)
  })
})
