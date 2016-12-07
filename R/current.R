#' get current weather data for given city
#'
#' @param city city name or id
#' @param ... see owm api
#'
#' @return list
#' @export
#'
#' @examples \dontrun{
#'    get_current("London", units = "metric")
#' }
get_current <- function(city = NA, ...){
  get <- owmr_wrap_get("weather")
  get(city, ...) %>% owmr_parse()
}

#' find city by name or coords (lat, lon)
#'
#' either search for city by name or fetch weather
#' data for a number of cities around geo point
#'
#' @param city city name (and country code)
#' @param ... see owm api
#'
#' @return list of weather data for matches
#' @export
#'
#' @examples \dontrun{
#'    find_city("London,UK")
#'    find_city(lat = 51.50853, lon = -0.12574, cnt = 5)
#' }
find_city <- function(city = NA, ...){
  get <- owmr_wrap_get("find")
  get(city, ...) %>% owmr_parse()
}
