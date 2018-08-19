folder_test_data <- "tests/testthat/data/"

# save data to test folder
save_test_data <- function(x, filename) {
  (fn <- paste0(folder_test_data, filename)) %>%
    saveRDS(x, .)
  sprintf("data written to %s\n", fn) %>% cat()
}

save_current <- function() {
  get_current("Kassel") %>%
    save_test_data("current.rds")
}

save_current_multiple <- function() {
  get_current_for_group(c(2831088, 2847639, 2873291)) %>%
    save_test_data("current_multiple.rds")
}

save_stations_multiple <- function() {
  find_stations_by_geo_point(lat = 51.31667, lon = 9.5, cnt = 15) %>%
    save_test_data("stations_multiple.rds")
}

# get (raw) response to be used in mockups
# should be done for other responses as well
get_response <- function(path = "weather", city = NA, ...) {
  mock_url <- "Hi folks!"
  response <- owmr_wrap_get(path)(city, ...)
  response$url <- mock_url -> response$request$url
  response
}

# Helper function to fetch test data.
#
# Updates test data before running tests.
#
# @param run_tests set \code{run_tests = TRUE} in order
#    to run tests after data was fetched succesfully
#
### @export
#
fetch_test_data <- function(run_tests = TRUE) {
  # save_current()
  # save_current_multiple()
  # save_stations_multiple()
  get_response("weather", "Kassel") %>%
    save_test_data("response-current.rds")
  get_response("forecast", "London") %>%
    save_test_data("response-forecast.rds")
  get_response("station/find", lat = 51.31667, lon = 9.5, cnt = 7) %>%
    save_test_data("response-stations_multiple.rds")
  # run tests
  if (run_tests) {
    testthat::test_dir("tests/testthat", reporter = "tap")
  }
}
