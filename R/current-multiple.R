#' Title
#'
#' @param city_ids vector containing city ids,
#'    see \code{\link{owm_cities}} dataset for ids
#' @param ... see owm api (units, ...)
#'
#' @return list containing data frame with weather data of cities
#' @export
#'
#' @examples \dontrun{
#'    city_ids = c(2831088, 2847639, 2873291)
#'    result <-get_current_for_group(city_ids)
#'    weather_frame <- result$list
#' }
get_current_for_group <- function(city_ids, ...){
  get <- owmr_wrap_get("group")
  get(id = paste(city_ids, collapse = ",")) %>%
    owmr_parse()
}
