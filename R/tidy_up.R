#' Tidy up owm data.
#'
#' @param data response (list) returned from owm
#' @param use_underscore substitute dots in column names with an underscore
#' @param remove_prefix prefices to be removed for shorter column names
#'    (\code{remove_prefix = NULL}) will keep all prefices
#'
#' @return response with 'clean' data frame
#' @export
#'
#' @examples \dontrun{
#'    result <- find_city("Malaga") %>% tidy_up()
#'    # keep dots in column names
#'    result <- find_city("Malaga") %>% tidy_up(use_underscore = FALSE)
#'    # keep all prefices
#'    result <- find_city("Malaga") %>% tidy_up(remove_prefix = NULL)
#' }
tidy_up <- function(data, use_underscore = TRUE, remove_prefix = c("main", "sys")){
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
  data
}
