owmr_parse <- function(response){
  httr::content(response, as = "text") %>%
    jsonlite::fromJSON()
}

get_current_new <- function(city){
  get <- "weather" %>% owmr_wrap_get()
  get(city)
}

get_forecast_new <- function(city){
  get <- "forecast" %>% owmr_wrap_get()
  get(city) %>% owmr_parse()
}
