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
      country_expected <- "GB"
      length_expected <- 16
      class_expected <- c("list", "owmr_forecast")

      expect_equal(result$city$country, country_expected)
      expect_length(result$list, length_expected)
      expect_equal(class(result), class_expected)
    }
  )
})

### TODO: use response returned from 'get_forecast'
test_that("parse forecast response", {
  # prepare
  resp <- mock_httr_GET() %>%
    owmr_parse() %>%
    owmr_class("owmr_forecast")

  # act
  data <- owmr_as_tibble(resp)
  first_columns <- names(data)[1:6]
  weather <- data[startsWith(names(data), "weather")]

  # assert
  first_columns_expected <- c(
    "dt_txt", "temp", "pressure", "humidity", "temp_min", "temp_max"
  )

  expect_is(data, "tbl")
  expect_equal(first_columns, first_columns_expected)
  expect_length(weather, 4)
})
