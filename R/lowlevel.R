api <- "http://api.openweathermap.org/data/2.5/"

assign_loc <- function(query, loc){
  # skip in case (lat, lon) or zip code is passed instead of city name or id
  if(is.na(loc)) {return(query)}
  if(is.numeric(loc)) {
    query$id <- loc
  } else{
    query$q <- loc
  }
  query
}

# TODO: document in order to export
# @export
owmr_parse <- function(response){
  httr::content(response, as = "text") %>%
    jsonlite::fromJSON(flatten = T)
}

# TODO: document in order to export
# @export
owmr_wrap_get <- function(appendix = "weather"){
  query = list(appid = get_api_key())
  api <- paste0(api, appendix)
  function(loc = NA, ...){
    #query$q <- city
    query %<>% assign_loc(loc)
    query %<>% c(list(...))
    httr::GET(api, query = query)
  }
}
