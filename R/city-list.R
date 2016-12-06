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
  result <- grepl(city, owm_cities$nm) &
    grepl(country_code, owm_cities$countryCode)
  owm_cities[result, ]
}
