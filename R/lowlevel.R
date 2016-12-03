api <- "http://api.openweathermap.org/data/2.5/"

# parse owm response
.parse <- function(response){
  httr::content(response) %>%
    as.data.frame(stringsAsFactors = F) %>%
    as.list()
}

#' @export
#'
.get <- function(appendix = "weather"){
  query = list(appid = get_api_key())
  api <- paste0(api, appendix)
  function(city, ...){
    query$q <- city
    query %<>% c(list(...))
    httr::GET(api, query = query) %>% .parse()
  }
}
