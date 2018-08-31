#' Render operator.
#'
#' Vectorizes function \code{\link[whisker]{whisker.render}}. \cr
#' \cr
#' NOTE: Because \pkg{whisker} does not support variable names
#' inlcuding dots, a \emph{dot} in column names is replaced by an \emph{underscore}.
#' Therefore, you must use an underscore in the template text for
#' varibales including dots.
#'
#' @param template template
#' @param data data frame where column names correspond to
#'    variables names in template
#'
#' @return rendered template
#' @rdname render
#' @export
#'
#' @seealso \code{\link[whisker]{whisker.render}}
#'
#' @examples
#' vars <- data.frame(a = 1:3, b = 23:21)
#' "a = {{a}} and b = {{b}}" %$$% vars
`%$$%` <- render <- function(template, data) {
  names(data) %<>% gsub("\\.", "_", .)
  if (!is.data.frame(data)) {
    return(whisker::whisker.render(template, data))
  }
  # add empty column for correct subsetting of data frames with only one column
  if (ncol(data) == 1) {
    random_name <- tempfile(pattern = "", tmpdir = "") %>%
      sub("/", "", .)
    data[random_name] <- 0L
  }
  sapply(1:nrow(data), function(i) {
    whisker::whisker.render(template, data[i, ])
  })
}

#' @name render
#' @export
NULL
