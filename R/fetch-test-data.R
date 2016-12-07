folder_test_data <- "tests/testthat/data/"

# save data to test folder
save_test_data <- function(x, filename){
  (fn <- paste0(folder_test_data, filename)) %>%
    saveRDS(x, .)
  sprintf("data written to %s", fn) %>% cat
}

save_current_multiple <- function(){
  get_current_for_group(c(2831088, 2847639, 2873291)) %>%
    save_test_data("current_weather_multiple.rds")
}

#' helper function to fetch test data
#'
#' helper function to update test data
#' before running tests, don't forget to set api key
#' via \code{owmr_setup} before trying to fetch data
#'
#' @param run_tests set to true in order to run tests after data
#'    was fetched succesfully
#'
#' @export
#'
fetch_test_data <- function(run_tests = TRUE){
  if(is.null(.pkg_env$api_key)){
    stop("Set api key before trying to fetch data!", call. = F)
  }
  # fetch current data
  current_weather <- get_current("Kassel")
  save(current_weather,
       file = paste0(folder_test_data, "current_weather.rda"))
  # fetch data from 15 stations around geo point
  stations_data <- find_stations_by_geo_point(lat = 51.31667, lon = 9.5, cnt = 15)
  save(stations_data,
       file = paste0(folder_test_data, "stations_data.rda"))
  sprintf("data files saved to %s", folder_test_data) %>% cat
  if(run_tests) testthat::test_dir("tests/testthat", reporter = "tap")
}
