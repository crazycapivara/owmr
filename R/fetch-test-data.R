folder_test_data <- "tests/testthat/data/"

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
fetch_test_data <- function(run_test = TRUE){
  if(is.null(.pkg_env$api_key)){
    stop("Set api key before trying to fetch data!", call. = F)
  }
  current_weather <- get_current("Kassel")
  save(current_weather,
       file = paste0(folder_test_data, "current_weather.rda"))
  sprintf("data files saved to %s", folder_test_data) %>% cat
  if(run_test) devtools::test(reporter = "tap")
}
