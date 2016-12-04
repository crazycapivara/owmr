#' get current
#'
#' @param city city name
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
