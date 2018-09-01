#' Get current weather data for given city.
#'
#' @param city city name or id
#' @param ... see owm api documentation, you can also skip parameter
#'   \code{city} and pass \code{lat} (latitude) and \code{lon} (longitude)
#'   or \code{zip} (zip code) instead
#'
#' @return list
#' @export
#'
#' @examples \dontrun{
#'    get_current("London", units = "metric")
#'    get_current(2643741, lang = "DE")
#'    get_current(lon = -0.09184, lat = 51.51279)
#'    get_current(zip = "94040,US")
#' }
get_current <- function(city = NA, ...) {
  get <- owmr_wrap_get("weather")
  get(city, ...) %>% owmr_parse()
}

#' Find city by name or coordinates.
#'
#' Either search for city by name or fetch weather
#' data for a number of cities around geo point.
#'
#' @param city city name (and country code)
#' @param ... see owm api documentation, pass \code{lat} and \code{lon}
#'    to search by coordinates
#'
#' @return list of weather data for matches
#' @export
#'
#' @seealso \link{find_cities_by_geo_point}
#'
#' @examples \dontrun{
#'    find_city("London,UK")
#'    find_city(lat = 51.50853, lon = -0.12574, cnt = 5)
#' }
find_city <- function(city = NA, ...) {
  get <- owmr_wrap_get("find")
  get(city, ...) %>% owmr_parse()
}
