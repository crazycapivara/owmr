#' Render template.
#'
#' Vectorizes \code{\link[whiskers]{whisker.render}}.
#'
#' @param template template
#' @param data data frame where column names correspond to
#'    variables names in template
#'
#' @return rendered template
#' @aliases "%$%"
#' @export
#'
#' @seealso \code{\link[whiskers]{whisker.render}}
#'
#' @examples
#' vars <- data.frame(a = 1:3, b = 23:21)
#' "a = {{a}} and b = {{b}}" %$% vars
render <- function(template, data){
  # add empty column for correct subsetting of data frames with only one column
  if(ncol(data) == 1) {
    random_name <- tempfile(pattern = "", tmpdir = "") %>%
      sub("/", "", .)
    data[random_name] <- 0L
  }
  sapply(1:nrow(data), function(i){
    whisker::whisker.render(template, data[i, ])
  })
}

`%$%` <- render
