#' Flatten weather column in data frame.
#'
#' @param data data frame containing weather column
#'
#' @return data frame with flattened weather (data)
#' @export
#'
#' @examples\dontrun{
#'    get_forecast("Kassel") %>% cbind_weather()
#' }
cbind_weather <- function(data) {
  data %<>% cbind(weather = flatten_weather(data$weather))
  data$weather <- NULL
  data
}
