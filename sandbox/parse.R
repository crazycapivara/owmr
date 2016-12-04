owmr_parse <- function(response){
  httr::content(response, as = "text") %>%
    jsonlite::fromJSON()
}

get_current_new <- function(city){
  get <- "weather" %>% .get()
  get(city)
}

get_forecast_new <- function(city){
  get <- "forecast" %>% .get()
  get(city) %>% owmr_parse()
}
