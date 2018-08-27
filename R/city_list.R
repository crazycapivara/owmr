#' Look up coordinates and city id in owm's city list.
#'
#' search \code{\link{owm_cities}} dataset by city name
#' and country code
#'
#' @seealso \code{\link{owm_cities}} dataset
#'
#' @param city city name (regex)
#' @param country_code two letter country code (AU, DE, ...),
#'    use \code{country_code = ""} as wildcard
#'
#' @return data frame with matches
#' @export
#'
#' @examples
#' search_city_list("London", "GB")
#' search_city_list("London")
#' search_city_list("Lond")
search_city_list <- function(city, country_code = "") {
  result <- grepl(city, owmr::owm_cities$nm) &
    grepl(country_code, owmr::owm_cities$countryCode)
  owmr::owm_cities[result, ]
}
