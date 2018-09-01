#' Apply functions to columns.
#'
#' @param data data frame
#' @param functions_ named list where keys correspond to column names
#'
#' @return updated data frame
#' @export
#'
#' @examples\dontrun{
#'    parse_dt <- function(x){as.POSIXct(x, origin = "1970-01-01")}
#'    forecast <- get_forecast("Kassel")$list
#'    forecast %<>% parse_columns(list(dt = parse_dt))
#' }
parse_columns <- function(data, functions_) {
  for (name in names(functions_)) {
    data[[name]] %<>% functions_[[name]]()
  }
  data
}

# TODO: document in order to export
parse_dt <- function(dt) { # nocov start
  as.POSIXct(dt, origin = "1970-01-01")
} # nocov end
