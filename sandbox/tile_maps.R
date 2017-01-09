owm_tile_server <- 'http://{s}.tile.openweathermap.org/map/%s/{z}/{x}/{y}.png'

owm_layer_options <- function(){
  list(
    Precipitation = "precipitation",
    Precipitation_classic_style = "precipitation_cls",
    Rain = "rain",
    Snow = "snow",
    Clouds = "clouds",
    Temperature = "temp",
    wind_speed = "wind"
  )
}

get_owm_tile_server <- function(layer_name = "temp"){
  sprintf(owm_tile_server, layer_name)
}
