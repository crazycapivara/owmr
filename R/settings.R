.pkg_env <- new.env()

#' @export
#' 
owmr_settings <- function(api_key){
  assign("api_key", api_key, .pkg_env)
}

get_api_key <- function(){
  .pkg_env$api_key
}