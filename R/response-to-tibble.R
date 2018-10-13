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

#' Parse owm response to tibble object
#'
#' @param resp response returned from OpenWeatherMap
#' @param simplify tibble only?
#'
#' @name response_to_tibble
NULL

### @export
parse_current <- function(resp, simplify = TRUE) {
  keys <- c("weather", "wind", "clouds")
  resp$weather %<>% utils::head(1) # only take first row
  data <- add_prefix(resp[keys])
  data <- cbind(
    dt_txt = parse_unixtime(resp$dt),
    sunrise = parse_unixtime(resp$sys$sunrise),
    sunset = parse_unixtime(resp$sys$sunset),
    resp$main,
    data$weather,
    data$wind,
    data$clouds #,
    # stringsAsFactors = FALSE
  ) %>%
    plyr::rbind.fill(response_structure, .) %>%
    tibble::as_tibble()
  if (simplify) return(data)

  resp$data <- data
  resp[c("main", keys)] <- NULL
  resp
}

#' @rdname response_to_tibble
#' @export
parse_response <- function(resp, simplify = TRUE) {
  if (is.null(resp$list)) return(parse_current(resp))

  if (is.null(resp$list$dt_txt) && resp$list$dt) {
    resp$list$dt_txt <- parse_unixtime(resp$list$dt)
  }

  # daily-forecast-response misses some prefices
  if(c("speed", "deg", "clouds") %in% names(resp$list) %>% all()) {
    replace_ <- c(speed = "wind_speed", deg = "wind_deg", clouds = "clouds_all")
    resp$list %<>% plyr::rename(replace_, warn_missing = FALSE)
    resp$list$temp <- resp$list$temp.day
  }

  # TODO: do we need 'tidyr' dependency?
  resp$data <- tidyr::unnest(resp$list, .sep = "_") %>%
    use_underscore() %>%
    remove_prefix("main") %>%
    plyr::rbind.fill(response_structure, .) %>%
    tibble::as_tibble()
  if (simplify) return(resp$data)

  resp$list <- NULL
  resp
}
