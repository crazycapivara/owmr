#' Merge weather.
#'
#' Flatten weather column (list of data frames) and append it to main (top level) data frame.
#'
#' @param x main data frame returned from owm
#' @param prefix prefix added to names of flattened weather data frame
#'
#' @return main data frame with weather data frame appended
## @export
#'
## @examples
merge_weather <- function(x, prefix = "weather."){
  weather <- flatten_weather(x$weather)
  names(weather) %<>% paste0(prefix, .)
  x$weather = NULL
  cbind(x, weather)
}
