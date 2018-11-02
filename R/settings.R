.pkg_env <- new.env()
.pkg_env$icon_url <- "http://openweathermap.org/img/w/%s.png"

#' owmr settings.
#'
#' Set api key. Internally it calls \code{\link{Sys.setenv}}
#' to store the api key in an environment variable called \code{OWM_API_KEY}.
#'
#' @param api_key owm api key
#'
#' @export
#'
#' @examples \dontrun{
#'    owmr_settings(api_key = "your-api-key")
#' }
owmr_settings <- function(api_key) {
  message("It is recommended that you store your api key in an environment variable called OWM_API_KEY.")
  Sys.setenv(OWM_API_KEY = api_key)
}

get_api_key <- function() {
  api_key <- Sys.getenv("OWM_API_KEY")
  if (identical(api_key, "")) {
    stop("Set api key before trying to fetch data!", call. = FALSE)
  }

  api_key
}

#' Get icon url.
#'
#' @param icon icon name as returned by owm
#'
#' @return icon url
#' @export
#'
#' @examples \dontrun{
#'    forecast <- get_forecast("London")$list
#'    weather <- flatten_weather(forecast$weather)
#'    icons <- get_icon_url(weather$icon)
#' }
get_icon_url <- function(icon) {
  sprintf(.pkg_env$icon_url, icon)
}
