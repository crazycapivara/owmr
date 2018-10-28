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
      name_expected <- "Kassel"
      country_expected <- "DE"
      length_expected <- 12
      class_expected <- c("list", "owmr_weather")

      expect_equal(result$name, name_expected)
      expect_equal(result$sys$country, country_expected)
      expect_length(result, length_expected)
      expect_equal(class(result), class_expected)
    }
  )
})
