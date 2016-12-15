#' Parse weather column to (single) data frame.
#'
#' @param x weather column (NOT name)
#'
#' @return data frame
#' @export
#'
#' @examples\dontrun{
#'    result <- get_forecast("Kassel", units = "metric")$list
#'    weather <- flatten_weather(result$weather)
#'    weather$description %>% print()
#' }
flatten_weather <- function(x){
  lapply(x, function(df){df[1, ]}) %>% do.call(rbind, .)
}

# TODO: document in order to export
#' Apply functions to columns of result.
#'
#' @param x result data frame
#' @param functions_ named where keys correspond to column names
#'
#' @return parsed result data frame
#' @export
#'
#' @examples\dontrun{
#'    parse_dt <- function(x){as.POSIXct(x, origin = "1970-01-01")}
#'    forecast <- get_forecast("Kassel")$list
#'    forecast %<>% parse_result(list(dt = parse_dt))
#' }
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
