An R Interface to OpenWeatherMap
================

[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/owmr)](https://cran.r-project.org/package=owmr)

`owmr` accesses **OpenWeatherMap's** API, a service providing weather data in the past, in the future and now and furthermore, serving weather map layers usable in frameworks like `leaflet`. In order to access its API you have to sign up for an API key at

-   <https://openweathermap.org>

Builds
------

**master**

[![Travis-CI Build Status](https://travis-ci.org/crazycapivara/owmr.svg?branch=master)](https://travis-ci.org/crazycapivara/owmr)

**develop**

[![Travis-CI Build Status](https://travis-ci.org/crazycapivara/owmr.svg?branch=develop)](https://travis-ci.org/crazycapivara/owmr)

Installation
------------

``` r
require("devtools")

# stable
install_github("crazycapivara/owmr")

# bleeding edge
install_github("crazycapivara/owmr", ref = "develop")
```

Introduction
------------

See **OpenWeatherMap's** API documentation for optional parameters, which can be passed to all functions fetching weather data via the `...` parameter in R

-   <https://openweathermap.org/api/>

``` r
library(owmr)
```

    ## owmr 0.7.2
    ##    another crazy way to talk to OpenWeatherMap's API
    ##    Documentation: type ?owmr or https://crazycapivara.github.io/owmr/
    ##    Issues, notes and bleeding edge: https://github.com/crazycapivara/owmr/

``` r
# pass api key
api_key_ = "your-api-key"
owmr_settings(api_key = api_key)

# get current weather data by city name
(res <- get_current("London", units = "metric") %>%
  flatten()) %>% names()
```

    ##  [1] "coord.lon"           "coord.lat"           "weather.id"         
    ##  [4] "weather.main"        "weather.description" "weather.icon"       
    ##  [7] "base"                "main.temp"           "main.pressure"      
    ## [10] "main.humidity"       "main.temp_min"       "main.temp_max"      
    ## [13] "visibility"          "wind.speed"          "wind.deg"           
    ## [16] "all"                 "dt"                  "sys.type"           
    ## [19] "sys.id"              "sys.message"         "sys.country"        
    ## [22] "sys.sunrise"         "sys.sunset"          "id"                 
    ## [25] "name"                "cod"

``` r
res[c("coord.lon", "coord.lat", "main.temp", "weather.description")]
```

    ## $coord.lon
    ## [1] -0.13
    ## 
    ## $coord.lat
    ## [1] 51.51
    ## 
    ## $main.temp
    ## [1] 4.01
    ## 
    ## $weather.description
    ## [1] "moderate rain"

``` r
# ... by city id
(rio <- with(owm_cities, owm_cities[nm == "Rio de Janeiro", ])) %>%
  as.list()
```

    ## $id
    ## [1] 3451190
    ## 
    ## $nm
    ## [1] "Rio de Janeiro"
    ## 
    ## $lat
    ## [1] -22.90278
    ## 
    ## $lon
    ## [1] -43.2075
    ## 
    ## $countryCode
    ## [1] "BR"

``` r
get_current(rio$id, units = "metric") %>%
  flatten() %>% .[c("name", "main.temp", "main.humidity", "wind.speed")]
```

    ## $name
    ## [1] "Rio de Janeiro"
    ## 
    ## $main.temp
    ## [1] 28.73
    ## 
    ## $main.humidity
    ## [1] 70
    ## 
    ## $wind.speed
    ## [1] 2.6

``` r
# get weather data from stations
find_stations_by_geo_point(lat = 51.31667, lon = 9.5, cnt = 7) %>% 
  .[c("distance", "station.id", "station.name", "last.main.temp")]
```

    ##   distance station.id station.name last.main.temp
    ## 1   13.276       4926         EDVK         274.15
    ## 2   26.926       4954         ETHF         276.15
    ## 3   69.579       4910         EDLP         275.15
    ## 4   89.149      73733    Uwe Kruse         275.55
    ## 5   93.344 1460732694        hlw31         275.43
    ## 6   97.934 1442728908         AmiH         273.15
    ## 7   98.978       4951         ETHB         276.15

``` r
# get forecast
forecast <- get_forecast("London", units = "metric")
names(forecast)
```

    ## [1] "city"    "cod"     "message" "cnt"     "list"

``` r
"name: {{name}}, id: {{id}}, (forcast) rows: {{cnt}}" %$$%
  list(
    name = forecast$city$name,
    id   = forecast$city$id,
    cnt  = forecast$cnt) %>% cat()
```

    ## name: London, id: 2643743, (forcast) rows: 35

``` r
names(forecast$list)
```

    ##  [1] "dt"              "weather"         "dt_txt"         
    ##  [4] "main.temp"       "main.temp_min"   "main.temp_max"  
    ##  [7] "main.pressure"   "main.sea_level"  "main.grnd_level"
    ## [10] "main.humidity"   "main.temp_kf"    "clouds.all"     
    ## [13] "wind.speed"      "wind.deg"        "rain.3h"        
    ## [16] "sys.pod"

``` r
forecast$list[c("dt_txt", "main.temp", "main.temp_max", "wind.speed")] %>%
  head()
```

    ##                dt_txt main.temp main.temp_max wind.speed
    ## 1 2017-01-14 15:00:00      4.74          5.04       4.81
    ## 2 2017-01-14 18:00:00      3.38          3.60       3.65
    ## 3 2017-01-14 21:00:00      3.38          3.52       3.97
    ## 4 2017-01-15 00:00:00      0.71          0.78       4.67
    ## 5 2017-01-15 03:00:00     -0.39         -0.39       3.95
    ## 6 2017-01-15 06:00:00     -0.55         -0.55       2.97

``` r
# flatten weather column and tidy up column names
forecast %<>% tidy_up()
names(forecast$list)
```

    ##  [1] "dt"                  "dt_txt"              "temp"               
    ##  [4] "temp_min"            "temp_max"            "pressure"           
    ##  [7] "sea_level"           "grnd_level"          "humidity"           
    ## [10] "temp_kf"             "clouds_all"          "wind_speed"         
    ## [13] "wind_deg"            "rain_3h"             "pod"                
    ## [16] "weather_id"          "weather_main"        "weather_description"
    ## [19] "weather_icon"

``` r
# apply funcs to some columns  
forecast$list %<>% parse_columns(list(temp = round, wind_speed = round))

# do some templating ...
("{{dt_txt}}h {{temp}}°C, {{wind_speed}} m/s" %$$%
  forecast$list) %>% head(10)
```

    ##  [1] "2017-01-14 15:00:00h 5°C, 5 m/s"  "2017-01-14 18:00:00h 3°C, 4 m/s" 
    ##  [3] "2017-01-14 21:00:00h 3°C, 4 m/s"  "2017-01-15 00:00:00h 1°C, 5 m/s" 
    ##  [5] "2017-01-15 03:00:00h 0°C, 4 m/s"  "2017-01-15 06:00:00h -1°C, 3 m/s"
    ##  [7] "2017-01-15 09:00:00h 1°C, 3 m/s"  "2017-01-15 12:00:00h 3°C, 3 m/s" 
    ##  [9] "2017-01-15 15:00:00h 6°C, 5 m/s"  "2017-01-15 18:00:00h 7°C, 4 m/s"

Documentation
-------------

-   <https://crazycapivara.github.io/owmr/>

or type

``` r
?owmr
```

Run tests
---------

``` r
test_dir("tests/testthat/")
```

    ## city list: ..
    ## mock httr::GET current: ...
    ## current weather data for multiple cities: ...
    ## current weather data: .....
    ## mock httr::GET forecast: ..
    ## parse columns: ..
    ## render operator: ...
    ## current weather data from multiple stations: ...
    ## tidy up data: ....
    ## 
    ## DONE ======================================================================
