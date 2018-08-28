api_url <- "http://api.openweathermap.org/data/2.5/"

assign_loc <- function(query, loc) {
  # skip in case (lat, lon) or zip code is passed instead of city name or id
  if (is.na(loc)) {
    return(query)
  }
  if (is.numeric(loc)) {
    query$id <- loc
  } else {
    query$q <- loc
  }
  query
}

# TODO: document in order to export
# @export
owmr_parse <- function(response) {
  httr::content(response, as = "text") %>%
    jsonlite::fromJSON(flatten = TRUE)
}

# TODO: document in order to export
# @export
owmr_wrap_get <- function(path = "weather") {
  api_url <- paste0(api_url, path)
  function(loc = NA, ...) {
    query <- list(appid = get_api_key()) %>%
      assign_loc(loc) %>%
      c(list(...))
    httr::GET(api_url, query = query)
  }
}
