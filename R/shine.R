keys_default <- c(
  "name",
  "coord.lon",
  "coord.lat",
  "main.temp"
)

helper_popups <- function(x, keys){
  x %<>% unlist() %>% .[keys] %>% unname()
  sapply(1:length(x), function(i){
    sprintf("<b>%s</b>: %s", keys[i], x[i])
  }) %>% paste0(collapse = "</br>")
}

#' shiny app to display weather data from owm
#'
#' @param title header of app
#' @param keys values, which should appear in popup
#'
#' @return shiny app
#'
#' @export
#'
owmr_shine <- function(title = "owmr -shine", keys = keys_default){
  loc <- search_city_list("Kassel")[1, ]
  # x == DATA
  DATA <- get_current("Kassel", units = "metric")

  view <- shiny::fluidPage(
    shiny::h1(title),
    leaflet::leafletOutput("map"),
    style = "font-family: Ubuntu;"
  )

  controller <- function(input, output){
    output$map <- leaflet::renderLeaflet({
      leaflet::leaflet() %>% leaflet::addTiles() %>%
        leaflet::setView(loc$lon, loc$lat, zoom = 12) %>%
        leaflet::addMarkers(loc$lon, loc$lat, popup = helper_popups(DATA, keys))
    })
  }
  shiny::shinyApp(view, controller, options = list(port = 12345))
}
