api <- "http://api.openweathermap.org/data/2.5/"

.parse <- function(response){
  httr::content(response) %>% as.data.frame()
}

#' @export
#' 
.get <- function(parse = TRUE){
  query = list(appid = get_api_key(), q = "London")
  api <- paste0(api, "weather")
  httr::GET(api, query = query) %>% .parse()
}