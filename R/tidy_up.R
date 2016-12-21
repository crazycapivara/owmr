#' Remove prefices from column names.
#'
#' @param data data frame
#' @param prefices vector of prefices to be removed from column names
#' @param sep prefix separator
#'
#' @return data frame with updated column names
#' @export
#'
#' @examples
#' x <- data.frame(main.temp = 1:10, sys.msg = "OK", cnt = 10:1)
#' names(x)
#' remove_prefix(x, c("main", "sys")) %>% names
remove_prefix <- function(data, prefices, sep = "."){
  for(prefix in prefices){
    prefix <- paste0(prefix, sep)
    names(data) %<>% gsub(prefix, "", .)
  }
  data
}

#' Substitute dots in column names with underscores.
#'
#' @param data data frame
#'
#' @return data frame with updated column names
#' @export
#'
#' @examples
#' names(airquality)
#' use_underscore(airquality) %>% names
use_underscore <-function(data){
  names(data) %<>% gsub("\\.", "_", .)
  data
}

#' Tidy up owm data.
#'
#' @param data data frame
#' @param flatten_weather_ see \code{\link{flatten_weather}}
#' @param use_underscore_ substitute dots in column names with underscores
#' @param remove_prefix_ prefices to be removed for shorter column names
#'    (\code{remove_prefix_ = NULL} will keep all prefices)
#'
#' @return updated data frame
#' @export
#'
#' @seealso
#'    \code{\link{tidy_up}},\cr
#'    \code{\link{remove_prefix}},\cr
#'    \code{\link{use_underscore}}
#'
#' @examples \dontrun{
#'    result <- find_city("Malaga")
#'    result$list %>% tidy_up_()
#'
#'    # keep dots in column names
#'    result$list %>% tidy_up_(use_underscore_ = FALSE)
#'
#'    # keep all prefices
#'    result$list %>% tidy_up_(remove_prefix_ = NULL)
#' }
tidy_up_ <- function(data, flatten_weather_ = TRUE, use_underscore_ = TRUE, remove_prefix_ = c("main", "sys")){
  # flatten weather
  if(flatten_weather_ & "weather" %in% colnames(data)){
    #data %<>% cbind(weather = flatten_weather(data$weather))
    #data$weather = NULL
    data %<>% cbind_weather()
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

#' Tidy up owm data.
#'
#' Calls \code{\link{tidy_up_}} passing \code{data$list}
#'    as \code{data} argument.
#'
#' @param data result returned from owm
#'    containing data frame in \code{data$list}
#' @param ... see \code{\link{tidy_up_}}
#'
#' @return updated data frame in \code{data$list}
#' @export
#'
#' @seealso \code{\link{tidy_up_}}
#'
#' @examples \dontrun{
#'    get_forecast("London") %>% tidy_up()
#' }
tidy_up <- function(data, ...){
  data$list %<>% tidy_up_(...)
  data
}
