#' Popup creator.
#'
#' Calls \code{paste0} in an environment constructed from passed
#' data.
#'
#' @param x data, usually a result data frame as returned by
#'    \link{\code{get_forecast}} or
#'    \link{\code{get_current_for_group}}
#' @param ... see \link{\code{paste0}}
#'
#' @return pasted objects
#' @export
#'
#' @examples \dontrun{
#'    df <- get_forcast("London", units = "metric", cnt = 7)$list
#'    popup(df, dt_txt, "</br>", main.temp)
#' }
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
