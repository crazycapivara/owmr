mock_httr_GET <- function(...) {
  readRDS("data/response-forecast.rds")
}

context("mock httr::GET forecast")

test_that("forecast data", {
  with_mock(
    `httr::GET` = mock_httr_GET, {
      # prepare
      api_key_org <- Sys.getenv("OWM_API_KEY")
      owmr_settings("my_api_key")
      city <- "London"

      # act
      result <- get_forecast(city)
      result$list$snow.3h <- NULL
      owmr_settings(api_key_org) # reset api key

      # assert
      expected_country <- "GB"
      expected_ncols <- 16

      expect_equal(result$city$country, expected_country)
      expect_equal(ncol(result$list), expected_ncols)
    }
  )
})
