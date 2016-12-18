shine_ <- function(title = "Keep on rocking in a free world"){
  # view
  view <- shiny::basicPage(
    shiny::h1(title),
    shiny::textInput("city", NULL, placeholder = "City name"),
    shiny::actionButton("search", "Search"),
    leaflet::leafletOutput("map")
  )
  # controller
  controller <- function(input, output){
    observeEvent(input$search, {
      sprintf("%s\n", input$city) %>% cat()
      df <- find_city(input$city)$list
      print(df)
      weather <- flatten_weather(df$weather)
      print(weather)
      leaflet::leafletProxy("map") %>%
        leaflet::setView(lng = df[1, ]$coord.lon, lat = df[1, ]$coord.lat, zoom = 12) %>%
        add_weather(df, template = "{{name}}, {{sys_country}}", icon = weather$icon)
    })
    output$map <- leaflet::renderLeaflet({
      leaflet::leaflet() %>%
        leaflet::addProviderTiles("CartoDB.DarkMatter")
    })
  }
  # create app
  shiny::shinyApp(view, controller)
}
