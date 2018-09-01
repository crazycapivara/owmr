.pkg_env <- new.env()
.pkg_env$icon_url <- "http://openweathermap.org/img/w/%s.png"
.pkg_env$api_key <- Sys.getenv("OWM_API_KEY")

#' owmr settings.
#'
#' Set api key.
#'
#' @param api_key owm api key
#'
#' @export
#'
#' @examples \dontrun{
#'    owmr_settings(api_key = "your-api-key")
#' }
owmr_settings <- function(api_key) {
  message("It still works, but it is recommended that you store your api key in an environment variable called OWM_API_KEY.")
  assign("api_key", api_key, .pkg_env)
}

get_api_key <- function() {
  if (identical(.pkg_env$api_key, "") && identical((.pkg_env$api_key <- Sys.getenv("OWM_API_KEY")), "")) {
    stop("Set api key before trying to fetch data!", call. = FALSE)
  }
  .pkg_env$api_key
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
