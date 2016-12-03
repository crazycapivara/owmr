api <- "http://api.openweathermap.org/data/2.5/"

# parse owm response
.parse <- function(response, raw = FALSE){
  x <- httr::content(response)
  if(raw) return(x)
  x %>%
    as.data.frame(stringsAsFactors = FALSE) %>%
    as.list()
}

#' @export
#'
# wrapper
.get <- function(appendix = "weather"){
  query = list(appid = get_api_key())
  api <- paste0(api, appendix)
  function(city, ...){
    query$q <- city
    query %<>% c(list(...))
    httr::GET(api, query = query)
  }
}
