#' Add weather data to leaflet map.
#'
#' @param map \code{\link[leaflet]{leaflet}} map object
#' @param data owm data
#' @param lng numeric vector of longitudes
#'    (if \code{NULL} it will be taken from \code{data})
#' @param lat numeric vector of latitudes
#'    (if \code{NULL} it will be taken from \code{data})
#' @param icon vector of owm icon names
#'    (usually included in weather column of owm data)
#' @param template template in the form of \cr
#'    \code{"<b>{{name}}</b>"} \cr
#'    where variable names in brackets correspond to
#'    column names of \code{data} (see also \code{\link{render}})
#' @param popup vector containing (HTML) content for popups,
#'    skipped in case parameter \code{template} is given
#' @param ... see \code{\link[leaflet]{addMarkers}}
#'
#' @return updated map object
#' @export
#'
#' @examples \dontrun{
#'    owm_data <- find_city("Malaga", units = "metric")$list %>% tidy_up_()
#'    map <- leaflet() %>% addTiles() %>%
#'       add_weather(owm_data,
#'          template = "<b>{{name}}</b>, {{main_temp}}°C",
#'          icon = owm_data$weather_icon)
#' }
add_weather <- function(map, data, lng = NULL, lat = NULL, icon = NULL, template = NULL, popup = NULL, ...) {
  if (is.null(lng) | is.null(lat)) {
    lng <- data[[grep("lon", names(data))]]
    lat <- data[[grep("lat", names(data))]]
  }
  if (!is.null(icon)) {
    icon %<>% get_icon_url() %>%
      leaflet::icons()
  }
  if (!is.null(template)) {
    popup <- template %$$% data
  }
  leaflet::addMarkers(map, lng, lat, data = data, icon = icon, popup = popup, ...)
}
