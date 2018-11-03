#' Find cities by bounding box.
#'
#' Get current weather data for a number of cities
#' within a given bounding box.
#'
#' @param bbox bounding box, numric vector of the form
#'   (lon-left, lat-bottom, lon-right, lat-top, zoom)
#' @param ... see \url{https://openweathermap.org/current}
#'
#' @export
find_cities_by_bbox <- function(bbox = c(12, 32, 15, 37, 10), ...) {
  get <- owmr_wrap_get("box/city")
  get(bbox = paste0(bbox, collapse = ","), ...) %>%
    owmr_parse() %>%
    owmr_class("owmr_box_city")
}
