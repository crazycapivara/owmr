#' owm city list containing ids and coordinates of cities.
#'
#' A dataset containing city ids and coordinates to be used in queries.
#'
#' @format data frame with 74071 rows and 4 variables:
#' \describe{
#'   \item{id}{city id}
#'   \item{nm}{city name}
#'   \item{lat}{latitude}
#'   \item{lon}{longitude}
#'   \item{countryCode}{two letter country code}
#' }
#' @source \url{http://openweathermap.org/help/city_list.txt}
#'
# NOTE: UTF-8 string found in `owm_cities$nm[7053]`
# Metabetchouan-Lac-a-la-Croix, needs to be fixed in case dataset
# is updated
"owm_cities"
