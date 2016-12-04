api <- "http://api.openweathermap.org/data/2.5/"

#' @export
#'
owmr_parse <- function(response){
  httr::content(response, as = "text") %>%
    jsonlite::fromJSON()
}

#' @export
#'
owmr_wrap_get <- function(appendix = "weather"){
  query = list(appid = get_api_key())
  api <- paste0(api, appendix)
  function(city, ...){
    query$q <- city
    query %<>% c(list(...))
    httr::GET(api, query = query)
  }
}
