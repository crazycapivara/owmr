# Main structure for all kind of responses,
# additional columns are just appended, see 'plyr::rbind.fill'
response_structure <- data.frame(
  dt_txt = character(),
  temp = numeric(),
  pressure = numeric(),
  humidity = numeric(),
  temp_min = numeric(),
  temp_max = numeric(),
  weather_id = numeric(),
  weather_main = character(),
  weather_description = character(),
  weather_icon = character(),
  wind_speed = numeric(),
  wind_deg = numeric(),
  clouds_all = numeric(),
  stringsAsFactors = FALSE
)

## Parse unixtime to txt
parse_unixtime <- function(secs) {
  structure(secs, class = "POSIXct") %>% strftime()
}

## Add main key as prefix
add_prefix <- function(data) {
  for (key in names(data)) {
    names(data[[key]]) %<>% paste0(key, "_", .)
  }

  data
}

parse_current <- function(resp, simplify = TRUE) {
  keys <- c("weather", "wind", "clouds")
  resp$weather %<>% utils::head(1) # only take first row
  data <- add_prefix(resp[keys])
  data <- cbind(
    dt_txt = parse_unixtime(resp$dt),
    dt_sunrise_txt = parse_unixtime(resp$sys$sunrise),
    dt_sunset_txt = parse_unixtime(resp$sys$sunset),
    resp$main,
    data$weather,
    data$wind,
    data$clouds,
    stringsAsFactors = FALSE
  ) %>%
    plyr::rbind.fill(response_structure, .) %>%
    tibble::as_tibble()
  if (simplify) return(data)

  resp$data <- data
  resp[c("main", keys)] <- NULL
  resp
}

parse_default <- function(resp, simplify = TRUE) {
  if (is.null(resp$list$dt_txt) && !is.null(resp$list$dt)) {
    resp$list$dt_txt <- parse_unixtime(resp$list$dt)
  }

  # TODO: do we need 'tidyr' dependency?
  # resp$data <- tidyr::unnest(resp$list, .sep = "_") %>%
  resp$data <- tidyr::unnest(resp$list, cols = c("weather"), names_sep = "_") %>%
    use_underscore() %>%
    remove_prefix("main") %>%
    plyr::rbind.fill(response_structure, .) %>%
    tibble::as_tibble()
  if (simplify) return(resp$data)

  resp$list <- NULL
  resp
}

# forecast-daily-response misses some prefices
parse_forecast_daily <- function(resp, simplify = TRUE) {
  replace_ <- c(speed = "wind_speed", deg = "wind_deg", clouds = "clouds_all")
  resp$list %<>% plyr::rename(replace_, warn_missing = FALSE)
  resp$list$temp <- resp$list$temp.day
  parse_default(resp, simplify)
}

#' Parse owmr response to tibble.
#'
#' @param resp response object returned from functions like
#'   \code{\link{get_current}} or \code{\link{get_forecast}}
#' @param simplify return tibble only?
#'
#' @return list containing tibble or tibble only (\code{simplify = TRUE})
#' @name owmr_as_tibble
#' @export
owmr_as_tibble <- function(resp, simplify = TRUE) {
  UseMethod("owmr_as_tibble", resp)
}

#' @name owmr_as_tibble
#' @export
owmr_as_tibble.owmr_weather <- parse_current

#' @name owmr_as_tibble
#' @export
owmr_as_tibble.default <- parse_default

#' @name owmr_as_tibble
#' @export
owmr_as_tibble.owmr_forecast_daily <- parse_forecast_daily
