#' Flatten list.
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
  as.data.frame(data, stringsAsFactors = FALSE)[1, ] %>%
    as.list()
}
