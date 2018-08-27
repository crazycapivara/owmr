#' owmr - An R interface to access OpenWeatherMap's API
#'
#' In order to access the API, you need to sign up for an API key
#' at \url{https://openweathermap.org/}. \cr
#' For optional parameters (\code{...}) in functions see
#' \url{https://openweathermap.org/api/}
#'
#' @name owmr
#'
#' @examples \dontrun{
#'    # first of all you have to set up your api key
#'    owmr_settings("your_api_key")
#'
#'    # get current weather data for "Kassel" with temperatures in °C
#'    get_current("Kassel", units = "metric")
#'
#'    # get 3h forcast data (7 rows)
#'    get_forecast("London", cnt = 7)
#'
#'    # ...
#' }
NULL

#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`

#' @importFrom magrittr %<>%
#' @export
magrittr::`%<>%`

exclusions <- list(
  "R/zzz.R",
  "R/fetch_test_data.R",
  "R/leaflet.R"
)

# export it or just run it in development mode?
owmr_coverage <- function() { # nocov start
  covr::package_coverage(line_exclusions = exclusions)
} # nocov end
