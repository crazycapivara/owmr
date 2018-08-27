owm_tile_server <- "http://{s}.tile.openweathermap.org/map/%s/{z}/{x}/{y}.png"

#' List available owm layers.
#'
#' @return list of available owm layers
#' @export
#'
owm_layers <- function() {
  list(
    Precipitation = "precipitation",
    Precipitation_classic_style = "precipitation_cls",
    Rain = "rain",
    Rain_classic_style = "rain_cls",
    Snow = "snow",
    Clouds = "clouds",
    Cloud_classic_style = "clouds_cls",
    Sea_level_pressure = "pressure",
    Sea_level_pressure_contour = "pressure_cntr",
    Temperature = "temp",
    Wind_speed = "wind"
  )
}

get_owm_tile_template <- function(layer_name = "temp") {
  sprintf(owm_tile_server, layer_name)
}

#' Add owm tiles to leaflet map.
#'
#' @param map leaflet map object
#' @param layer_name owm layer name,
#'    see \code{\link{owm_layers}}
#' @param ... optional parameters passed to
#'    \code{\link[leaflet]{addTiles}}
#'
#' @return updated map object
#' @export
#'
#' @examples \dontrun{
#'    leaflet() %>% add_owm_tiles() %>%
#'       addMarkers(data = quakes[1:20, ])
#' }
#'
add_owm_tiles <- function(map, layer_name = "temp", ...) {
  tile_template <- get_owm_tile_template(layer_name)
  leaflet::addTiles(map, tile_template, ...)
}
