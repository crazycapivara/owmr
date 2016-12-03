#' get current
#'
#' @param city city name
#' @param ... see owm api
#'
#' @return list
#' @export
#'
#' @examples \dontrun{
#'    get_current("London", units = "metric")
#' }
get_current <- function(city = NA, ...){
  wrapper <- .get("weather")
  wrapper(city, ...)
}
