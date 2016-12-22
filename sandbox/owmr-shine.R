library(magrittr)

owmr_shine <- function(title = "shine", city_ = "London"){
  tpl <- "<center><b>__{{name}}__</b></br>{{temp}} °C, {{humidity}} %, {{wind_speed}} m/s</br><i>{{weather_description}}</i></center>"
  city <- search_city_list(city_)[1, ]
  # view
  view <- shiny::basicPage(
    shiny::h1(title),
    leaflet::leafletOutput("map")
  )
  # controller
  controller <- function(input, output){
    observeEvent(input$map_click,{
      #print("clicked")
      print(input$map_click)
      coords <- input$map_click
      res <- find_cities_by_geo_point(
        lon = coords$lng,
        lat = coords$lat,
        units = "metric"
      ) %>% tidy_up()
      print(res)
      lng = mean(res$list$coord_lon)
      lat = mean(res$list$coord_lat)
      print(lng)
      leaflet::leafletProxy("map") %>%
        add_weather(res$list, icon = res$list$weather_icon, template = tpl) %>%
        leaflet::setView(lng = lng, lat = lat, zoom = 12)
    })
    output$map <- leaflet::renderLeaflet({
      leaflet::leaflet() %>%
        leaflet::addTiles() %>% #leaflet::addProviderTiles("CartoDB.DarkMatter")
        leaflet::setView(lng = city$lon, lat = city$lat, zoom = 12)
        })
  }
  # app
  shiny::shinyApp(view, controller)
}

# find city app
crazy_diamond <- function(title = "crazy diamond"){
  view <- shiny::basicPage(
    #shiny::tags$head(
    #  shiny::tags$style(shiny::HTML("#city {background: yellow; float: right;}"))
    #),
    shiny::h1(title),
    shiny::textInput("city", "", placeholder = "your city"),
    shiny::actionButton("search", "Search"),
    leaflet::leafletOutput("map", height = 200)
  )

  controller <- function(input, output){
    observeEvent(input$search, {
      print(input$city)
      res <- find_city(input$city) %>% tidy_up()
      print(res)
      lng = mean(res$list$coord_lon)
      lat = mean(res$list$coord_lat)
      leaflet::leafletProxy("map") %>%
        add_weather(res$list, icon = res$list$weather_icon, template = NULL) %>%
        leaflet::setView(lng = lng, lat = lat, zoom = 12)
    })
    output$map <- leaflet::renderLeaflet(
      leaflet::leaflet() %>% leaflet::addTiles()
    )
  }
  shiny::shinyApp(view, controller)
}
