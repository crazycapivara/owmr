#' Flatten weather column.
#'
#' For muliple cities or stations a nested weather column containing
#' a list with more or less weather description and icon for each city/station is returned by owm.
#' \code{flatten_weather} just extracts a given row from the list.
#' Usually there is only one entry in the list. Therfore, by default
#' the first row is returned.
#'
#' @param x weather column (NOT name)
#' @param row row to extract from weather list (data frame)
#'
#' @return data frame
#' @export
#'
#' @examples\dontrun{
#'    result <- get_forecast("Kassel", units = "metric")$list
#'    weather <- flatten_weather(result$weather)
#'    weather$description %>% print()
#' }
flatten_weather <- function(x, row = 1){
  lapply(seq_along(x), function(i){
    x[[i]][row, ]}) %>% do.call(rbind, .)
}

# TODO: document in order to export
parse_result <- function(x, functions_){
  for(name in names(functions_)){
    x[[name]] %<>% functions_[[name]]()
  }
  x
}

# TODO: document in order to export
parse_dt <- function(dt){
  as.POSIXct(dt, origin = "1970-01-01")
}
