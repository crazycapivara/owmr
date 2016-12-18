#' Flatten nested data frames.
#'
#' Just wraps \code{\link[tidyr]{unnest}} (package \pkg{tidyr}
#' setting paremeter \code{sep = "."} by default.
#'
#' @param data data frame
#' @param sep separator used to combine nested (list) column names with column
#'    names of nested data frames
#'
#' @return unnested/flattened data frame
#' @export
#'
#' @seealso \code{\link[tidyr]{unnest}}
#'
## @examples
flatten_ <- function(data, sep = "."){
  tidyr::unnest(data, .sep = "_")
}
