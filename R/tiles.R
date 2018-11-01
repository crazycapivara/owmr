owm_tile_server <- "http://{s}.tile.openweathermap.org/map/%s/{z}/{x}/{y}.png?appid=%s"

get_owm_tile_template <- function(layer_name) {
  sprintf(owm_tile_server, layer_name, get_api_key())
}

#' Add owm tiles to leaflet map.
#'
#' @param map leaflet map object
#' @param layer_name owm layer name,
#'    see \code{\link{owm_layers}}
#' @param ... optional parameters passed to \code{\link[leaflet]{addTiles}}
#'
#' @return updated map object
#' @export
#'
#' @examples \dontrun{
#'    leaflet() %>% add_owm_tiles() %>%
#'       addMarkers(data = quakes[1:20, ])
#' }
add_owm_tiles <- function(map, layer_name = owm_layers$Temperature_new, ...) {
  tile_template <- get_owm_tile_template(layer_name)
  leaflet::addTiles(map, tile_template, ...)
}
