#' Flatten list. (DEPRECATED)
#'
#' @param data list returned from owm
#'
#' @return flattened list
#' @export
#'
#' @examples \dontrun{
#'    get_current("Rio de Janeiro") %>% flatten()
#'    get_current("Rio de Janeiro") %>% flatten() %>%
#'       tidy_up_()
#' }
flatten <- function(data) {
  .Deprecated("owmr_as_tibble")
  as.data.frame(data, stringsAsFactors = FALSE)[1, ] %>%
    as.list()
}
