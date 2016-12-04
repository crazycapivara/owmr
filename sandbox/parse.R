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

forecast <- get_forecast("Kassel")

forecast$list[,c("dt_txt", "main")] %>%
  as.list() %>% as.data.frame() %>%
  .[c("dt_txt", "main.temp")]
