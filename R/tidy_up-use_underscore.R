#' Substitute dots in column names with underscores.
#'
#' @param data data frame
#'
#' @return data frame with updated column names
#' @export
#'
#' @examples
#' names(airquality)
#' use_underscore(airquality) %>% names()
use_underscore <- function(data) {
  names(data) <- gsub("\\.", "_", names(data))
  data
}
