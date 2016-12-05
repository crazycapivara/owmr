#' get current weather for given city
#'
#' @param city city name or id
#' @param ... see owm api for optional parameters
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

#' find city by name or (lat, lon)
#'
#' either search for city by name or fetch weather
#' for a number of cities around geo point
#'
#' @param city city name (and country code)
#' @param ... see owm api
#'
#' @return weather list for matches
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
