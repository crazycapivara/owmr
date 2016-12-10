#' owmr - An R interface to OpenWeatherMap
#'
#' @name owmr
#'
#' @examples \dontrun{
#'    get_current("Kassel", units = "metric")
#'    get_forecast("London", cnt = 7)
#'    # ...
#' }
#'
#' @importFrom magrittr %>% %<>%
#' @export %>%
NULL

#' pipe operator
#'
#' exported from \pkg{magrittr}
#'
#' @aliases %>%
#' @name pipe
NULL

exclusions <- c("R/fetch-test-data.R")

owmr_coverage <- function(){ # nocov start
  covr::package_coverage(line_exclusions = exclusions)
} # nocov end
