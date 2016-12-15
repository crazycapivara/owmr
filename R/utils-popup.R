popup <- function(x, ...){
  cmd <- substitute(paste0(...))
  with(x, eval(cmd))
}

#' Wrap html tag around value.
#'
#' @param tag tag like \code{i}, \code{strong} or whatever
#' @param value value to be wrapped around
#'
#' @return wrapped value
#' @export
#'
#' @examples
#' x <- get_current("London", units = "metric")
#' # create a simple popup to show up on a (leaflet) map
#' popup <- wrap("strong", x$main$temp)
#'
wrap <- function(tag, value){
  sprintf("<%s>%s</%s>", tag, value, tag)
}
