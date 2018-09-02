#' Parse owm data to tibble object
#'
#' @param resp (list) Result returned from \code{\link{get_current}}
#'   or \code{\link{get_forecast}}
#' @param simplify (boolean) Should "extra" columns like ids and icons be comitted from the dataframe output?
#' @param ... Further arguments.
#'
#' @return A dataframe containing weather-relevant information.
#'
#' @name as_tibble
as_tibble <- function(resp, simplify = TRUE, ...) {
  if (resp$timeframe == "current") {
    out <- resp %>% current_as_tibble()
  } else if (resp$timeframe == "forecast") {
    out <- resp %>% forecast_as_tibble()
  } else {
    stop("Only current and forecast responses can be parsed into tibbles.")
  }
  out
}

#' @rdname as_tibble
#' @export
current_as_tibble <- function(resp, simplify = TRUE, ...) {
  resp$weather <- resp$weather %>%
    tibble::as_tibble() %>%
    use_underscore()

  resp$main <- resp$main %>%
    tibble::as_tibble()

  resp$data <- resp$weather %>%
    cbind(resp$main) %>%
    cbind(
      clouds_all = resp$clouds$all,
      wind_speed = resp$wind$speed
    ) %>%
    tibble::as_tibble()

  if (simplify == TRUE) {
    return(resp$data %>%
             unselect_cols())
  }
  resp
}



#' @rdname as_tibble
#' @export
forecast_as_tibble <- function(resp, simplify = TRUE, ...) {
  if ("list" %in% names(resp) &&
      inherits(resp$list, "data.frame")) {
    names(resp)[which(names(resp) == "list")] <- "data"
  }

  resp$data <- resp$data %>%
    tibble::as_tibble() %>%
    tidyr::unnest() %>%
    use_underscore() %>%
    nix_mains()

  if (simplify == TRUE) {
    return(resp$data %>%
             unselect_cols())
  }
  resp
}

