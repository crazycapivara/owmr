mock_httr_GET <- function(...) {
  readRDS("data/response-current.rds")
}

context("mock httr::GET current")

test_that("current weather data", {
  with_mock(
    `httr::GET` = mock_httr_GET, {
      # prepare
      api_key_org <- Sys.getenv("OWM_API_KEY")
      owmr_settings("my_api_key")
      city <- "Kassel"

      # act
      result <- get_current(city)
      Sys.setenv(OWM_API_KEY = api_key_org)

      # assert
      expected_name <- "Kassel"
      expected_country <- "DE"
      expected_nitems <- 12 # number of items

      expect_equal(result$name, expected_name)
      expect_equal(result$sys$country, expected_country)
      expect_equal(length(result), expected_nitems)
    }
  )
})
