#' Get 3h forecast data.
#'
#' @inheritParams get_current
# @param city city name or id
# @param ... see owm api documentation
#'
#' @return list
#' @export
#'
#' @examples \dontrun{
#'    result <- get_forecast("Kassel", units = "metric")
#'    names(result)
#'    get_forecast("London", cnt = 10)
#'    get_forecast(lat = -22.90278, lon = -22.90278, cnt = 3, units = "metric")
#' }
get_forecast <- function(city = NA, ...) {
  get <- owmr_wrap_get("forecast")
  get(city, ...) %>% owmr_parse()
}
