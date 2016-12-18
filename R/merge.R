merge_weather <- function(x, prefix = "weather."){
  weather <- flatten_weather(x$weather)
  names(weather) %<>% paste0(prefix, .)
  x$weather = NULL
  cbind(x, weather)
}
