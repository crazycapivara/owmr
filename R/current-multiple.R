#' Get current weather data for multiple cities.
#'
#' @seealso \code{\link{owm_cities}} dataset in order to
#'    lookup city ids
#'
#' @param city_ids numeric vector containing city ids
#' @param ... see owm api documentation
#'
#' @return list containing data frame with current weather data of cities
#' @export
#'
#' @examples \dontrun{
#'    city_ids = c(2831088, 2847639, 2873291)
#'    result <- get_current_for_group(city_ids)
#'    result$cnt == nrow(result$list)
#'    weather_frame <- result$list
#' }
get_current_for_group <- function(city_ids, ...) {
  get <- owmr_wrap_get("group")
  get(id = paste(city_ids, collapse = ",")) %>%
    owmr_parse()
}

#' Find cities by geo point.
#'
#' Get current weather data for a number of cities
#' around given geo point.
#'
#' @param lat latitude of geo point
#' @param lon longitude of geo point
#' @param cnt number of cities
#' @param ... see owm api documentation
#'
#' @return list containing data frame with weather data
#'
#' @export
#'
#' @seealso \code{\link{find_city}}
#'
#' @examples \dontrun{
#'   find_cities_by_geo_point(lat = 51.50853, lon = -0.12574, cnt = 5)
#' }
find_cities_by_geo_point <- function(lat, lon, cnt = 3, ...) {
  find_city(lat = lat, lon = lon, cnt = cnt, ...)
}
