.pkg_env <- new.env()
.pkg_env$icon_url = "http://openweathermap.org/img/w/%s.png"

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
owmr_settings <- function(api_key){
  assign("api_key", api_key, .pkg_env)
}

get_api_key <- function(){
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
get_icon_url <- function(icon){
  sprintf(.pkg_env$icon_url, icon)
}
