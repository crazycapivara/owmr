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
#' remove_prefix(x, c("main", "sys")) %>% names()
remove_prefix <- function(data, prefices, sep = ".") {
  for (prefix in prefices) {
    prefix <- paste0(prefix, sep)
    names(data) %<>% gsub(prefix, "", .)
  }
  data
}
