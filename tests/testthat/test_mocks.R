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
      name <- "Kassel"
      country <- "DE"
      len <- 12 # length
      # -----
      result <- get_current(city)
      owmr_settings(NULL)
      expect_equal(result$name, name)
      expect_equal(result$sys$country, country)
      expect_equal(length(result), 12)
    }
  )
})
