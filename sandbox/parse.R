owmr_parse_new <- function(response){
  httr::content(response, as = "text") %>%
    jsonlite::fromJSON(flatten = T)
}

get_current_new <- function(city){
  get <- "weather" %>% owmr_wrap_get()
  get(city)
}

get_forecast_new <- function(city){
  get <- "forecast" %>% owmr_wrap_get()
  get(city) %>% owmr_parse_new()
}

forecast <- get_forecast_new("Kassel")

forecast$list[,c("dt_txt", "main")] %>%
  as.list() %>% as.data.frame() %>%
  .[c("dt_txt", "main.temp")]
