#' Get 3h forecast.
#'
#' @param city city name or id
#' @param ... see owm api documentation
#'
#' @return list
#' @export
#'
#' @examples \dontrun{
#'    result <- get_forecast("Kassel", units = "metric")
#'    names(result)
#' }
get_forecast <- function(city = NA, ...){
  get <- owmr_wrap_get("forecast")
  get(city, ...) %>% owmr_parse()
}
