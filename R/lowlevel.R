owmr_key <- function(quiet = TRUE) {
  .pkg_env$api_key <<- Sys.getenv("OWMR_KEY")
  if (identical(.pkg_env$api_key, "")) {
    return(NULL)
  }
  if (!quiet) {
    message("Using OWMR API key from envvar OWMR_KEY")
  }
  return(.pkg_env$api_key)
}


api_url <- "http://api.openweathermap.org/data/2.5/"

assign_loc <- function(query, loc){
  # skip in case (lat, lon) or zip code is passed instead of city name or id
  if(is.na(loc)){
    return(query)
  }
  if(is.numeric(loc)) {
    query$id <- loc
  } else{
    query$q <- loc
  }
  query
}

check_api_key <- function() {
  if (is.null(owmr_key())) {
    message("It is recommended that you store your OWMR API key in an\n
            .Renviron variable called OWMR_KEY.")
    if(is.null(.pkg_env$api_key)){
      stop("Set api key before trying to fetch data!", call. = FALSE)
    }
  } else {
    .pkg_env$api_key <<- Sys.getenv("OWMR_KEY")
  }
}

# TODO: document in order to export
# @export
owmr_parse <- function(response){
  httr::content(response, as = "text") %>%
    jsonlite::fromJSON(flatten = T)
}

parse_forecast <- function(resp, simplify = FALSE) {
  if ("list" %in% names(resp) &&
      inherits(resp$list, "data.frame")) {
    names(resp)[which(names(resp) == "list")] <- "weather"
  }

  resp$weather <- resp$weather %>%
    tibble::as_tibble() %>%
    use_underscore()

  if (simplify == TRUE) {
    return(resp$weather)
  }
  resp
}

parse_current <- function(resp, simplify = FALSE) {
  resp$weather <- resp$weather %>%
    tibble::as_tibble() %>%
    use_underscore()

  resp$main <- resp$main %>%
    tibble::as_tibble()

  resp
}

# TODO: document in order to export
# @export
owmr_wrap_get <- function(path = "weather"){
  api_url <- paste0(api_url, path)
  function(loc = NA, ...){
    check_api_key()
    query <- list(appid = get_api_key()) %>%
      assign_loc(loc) %>% c(list(...))
    httr::GET(api_url, query = query)
  }
}

