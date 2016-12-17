add_weather <- function(map, data, lng = NULL, lat = NULL, icon = NULL, template = NULL, popup = NULL, ...){
  if(is.null(lng) | is.null(lat)){
    if(!is.data.frame(data)){
      lng <- data$coord$lon
      lat <- data$coord$lat
    } else{
      lng = ~coord.lon
      lat = ~coord.lat
    }
  }
  if(!is.null(icon)){
    icon %<>% get_icon_url() %>%
      leaflet::icons()
  }
  if(!is.null(template)){
    popup <- template %$$% data
  }
  leaflet::addMarkers(map, lng, lat, data = data, icon = icon, popup = popup, ...)
}
