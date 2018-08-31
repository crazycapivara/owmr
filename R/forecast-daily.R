#' Get daily forcast data up to 16 days.
#'
#' @inheritParams get_current
# @param city city name or id
# @param ... see owm api documentation
#'
#' @return list
#' @export
#'
#' @examples \dontrun{
#'    # 9 day forecast
#'    result <- get_forecast_daily("London", cnt = 9)
#'    forecast_frame <- result$list
#' }
get_forecast_daily <- function(city = NA, ...) {
  get <- owmr_wrap_get("forecast/daily")
  get(city, ...) %>% owmr_parse()
}
