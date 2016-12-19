tidy_up <- function(data, use_underscore = TRUE, remove_prefix = c("main")){
  # flatten weather
  data$list %<>% cbind(weather = flatten_weather(.[, "weather"]))
  data$list$weather = NULL
  # remove prefices
  if(!is.null(remove_prefix)){
    for(prefix in remove_prefix){
      prefix %<>% sprintf("%s.", .)
      names(data$list) %<>% gsub(prefix, "", .)
    }
  }
  # substitute dots with underscore
  if(use_underscore){
    names(data$list) %<>% gsub("\\.", "_", .)
  }
  #names(data$list) %<>% gsub("main.", "", .) %>% gsub("\\.", "_", .)
  data
}
