#' get forecast
#'
#' @param city city name
#' @param ... see owm api for optional parameters
#'
#' @return list
#' @export
#'
#' @examples \dontrun{
#'    get_forecast("Kassel", units = "metric")
#' }
get_forecast <- function(city, ...){
  wrapper <- .get("forecast")
  wrapper(city, ...) %>% .parse(raw = TRUE)
}
