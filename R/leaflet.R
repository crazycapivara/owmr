#render <- function(template, data){
#  # add empty column for correct subsetting of data frames with only one column
#  if(ncol(data) == 1) {
#    random_name <- tempfile(pattern = "", tmpdir = "") %>%
#      sub("/", "", .)
#    data[random_name] <- 0L
#  }
#  sapply(1:nrow(data), function(i){
#    whisker::whisker.render(template, data[i, ])
#  })
#}
#
#`%$%` <- render

add_weather <- function(map, data = NULL, lng = NULL, lat = NULL, icon = NULL, ...){
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
  leaflet::addMarkers(map, lng, lat, data = data, icon = icon, ...)
}
