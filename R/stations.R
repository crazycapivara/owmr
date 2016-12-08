#' find stations by geo point
#'
#' get weather list from a given number of stations around geo point
#'
#' @param lat latitude of geo point
#' @param lon longitude of geo point
#' @param cnt number of stations
#'
#' @return data frame
#' @export
#'
#' @examples \dontrun{
#'    # get weather data from 7 stations
#'    find_stations_by_geo_point(lat = 51.31667, lon = 9.5, cnt = 7)
#' }
find_stations_by_geo_point <- function(lat, lon, cnt = 10){
  get <- owmr_wrap_get("station/find")
  get(lat = lat, lon = lon, cnt = cnt) %>% owmr_parse()
}

#' get current weather data from given station
#'
#' @param station_id station id
#' @param ... see owm api
#'
#' @return list
#' @export
#'
# TODO: document it, example id: 4926
get_current_from_station <- function(station_id, ...){
  get <- owmr_wrap_get("station")
  get(station_id, ...) %>% owmr_parse()
}
