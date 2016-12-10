#' shiny app to display weather data from owm
#'
#' @export
#'
owmr_shine <- function(title = "owmr -shine"){
  loc <- search_city_list("Kassel")[1, ]

  view <- shiny::fluidPage(
    shiny::h1(title),
    leaflet::leafletOutput("map"),
    style = "font-family: Ubuntu;"
  )

  controller <- function(input, output){
    output$map <- leaflet::renderLeaflet({
      leaflet::leaflet() %>% leaflet::addTiles() %>%
        leaflet::setView(loc$lon, loc$lat, zoom = 12) %>%
        leaflet::addMarkers(loc$lon, loc$lat)
    })
  }
  shiny::shinyApp(view, controller, options = list(port = 12345))
}
