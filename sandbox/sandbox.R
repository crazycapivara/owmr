forecast <- get_forecast("Kassel", units = "metric")

forecast$list %>% names()

forecast$list[c("dt_txt", "main.temp", "main.temp_max", "wind.speed")] %>%
  head()

forecast %>% names
forecast$cnt
nrow(forecast$list)
forecast$message

# ... by coordinates
get_current(lon = rio$lon, lat = rio$lat) %>%
  unlist() %>% .[c("sys.sunrise", "sys.sunset")] %>%
  as.numeric() %>% as.POSIXct(origin = "1970-01-01")
