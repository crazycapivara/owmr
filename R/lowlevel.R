api <- "http://api.openweathermap.org/data/2.5/"

.parse <- function(response){
  httr::content(response) %>% as.data.frame()
}

#' @export
#' 
.get <- function(parse = TRUE){
  api <- paste0(api, "weather")
  query = list(appid = api_key, q = "London")
  httr::GET(api, query = query) %>% .parse()
}