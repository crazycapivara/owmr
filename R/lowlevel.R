
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

owmr_key <- function(quiet = TRUE) {
  .pkg_env$api_key <- Sys.getenv("OWMR_KEY")
  if (identical(.pkg_env$api_key, "")) {
    return(NULL)
  }
  if (!quiet) {
    message("Using OWMR API key from envvar OWMR_KEY")
  }
  .pkg_env$api_key
}

check_api_key <- function() {
  if (is.null(owmr_key())) {
    message("It is recommended that you store your OWMR API key in an
.Renviron variable called OWMR_KEY.")
    if(is.null(.pkg_env$api_key)){
      stop("Set api key before trying to fetch data with owmr_settings()
or by storing your key in an .Renviron variable called OWMR_KEY.", call. = FALSE)
    }
  } else {
    .pkg_env$api_key <- Sys.getenv("OWMR_KEY")
  }
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

# TODO: document in order to export
# @export
owmr_parse <- function(response){
  httr::content(response, as = "text") %>%
    jsonlite::fromJSON(flatten = T)
}

extra_cols <- c("id", "icon")

unselect_cols <- function(tbl) {
  if (any(extra_cols %in% names(tbl))) {
    tbl[, -which(names(tbl) %in% extra_cols)]
  } else {
    tbl
  }
}

nix_mains <- function(tbl) {
  names(tbl) <-
    gsub("main_", "", names(tbl))

  tbl
}

parse_forecast <- function(resp, simplify = FALSE) {
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

parse_current <- function(resp, simplify = FALSE) {
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

