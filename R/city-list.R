#' search for given city in owm's city list
#'
#' @description see also \code{owm_cities} dataset
#'
#' @param city city name
#' @param country_code two letter country code (AU, DE, ...)
#'
#' @return data frame with matches
#' @export
#'
#' @examples
#' # TODO
search_city_list <- function(city, country_code = ""){
  #data("owm_cities", package = "owmr")
  result <- grepl(city, owmr::owm_cities$nm) &
    grepl(country_code, owmr::owm_cities$countryCode)
  owmr::owm_cities[result, ]
}
