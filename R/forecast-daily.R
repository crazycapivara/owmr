#' get daily forcast up to 16 days
#'
#' @param loc city name
#' @param ... see owm api parameters
#'
#' @return list
#' @export
#'
#' @examples \dontrun{
#'    # 9 days forecast
#'    get_forecast_daily("London", cnt = 9)
#' }
get_forecast_daily <- function(loc = NA, ...){
  get <- owmr_wrap_get("forecast/daily")
  get(loc, ...) %>% owmr_parse()
}
