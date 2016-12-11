.pkg_env <- new.env()

#' owmr settings.
#'
#' Set api key.
#'
#' @param api_key owm api key
#'
#' @export
#'
#' @examples \dontrun{
#'    owmr_settings(api_key = "your-api-key")
#' }
owmr_settings <- function(api_key){
  assign("api_key", api_key, .pkg_env)
}

get_api_key <- function(){
  .pkg_env$api_key
}
