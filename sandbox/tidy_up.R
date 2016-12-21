remove_prefix <- function(data, prefices){
  for(prefix in prefices){
    prefix %<>% sprintf("%s.", .)
    names(data) %<>% gsub(prefix, "", .)
  }
  data
}

use_underscore <-function(data){
  names(data) %<>% gsub("\\.", "_", .)
  data
}

tidy_up <- function(data, ...){
  data$list %<>% tidy_up_(...)
  data
}

tidy_up_ <- function(data, flatten_weather_ = TRUE, use_underscore_ = TRUE, remove_prefix_ = c("main")){
  # flatten weather
  if(flatten_weather_ & "weather" %in% colnames(data)){
    data %<>% cbind(weather = flatten_weather(data$weather))
    data$weather = NULL
  }
  # remove prefices
  if(!is.null(remove_prefix_)){
    data %<>% remove_prefix(remove_prefix_)
  }
  # substitute dots with underscore
  if(use_underscore_){
    data %<>% use_underscore()
  }
  data
}
