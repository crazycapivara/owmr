OpenWeatherMap Api Wrapper for R
================

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

Current version
---------------

``` r
library(owmr)
```

    ## owmr 0.6.5
    ##    another crazy way to talk to OpenWeatherMap's api
    ##    Documentation: type ?owmr or https://crazycapivara.github.io/owmr/
    ##    Issues, notes and bleeding edge: https://github.com/crazycapivara/owmr/

Introduction
------------

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
    ## [1] 8.15
    ## 
    ## $weather.description
    ## [1] "mist"

``` r
# ... by city id
(rio <- with(owm_cities, owm_cities[nm == "Rio de Janeiro", ]))
```

    ##            id             nm       lat      lon countryCode
    ## 13374 3451190 Rio de Janeiro -22.90278 -43.2075          BR

``` r
get_current(rio$id, units = "metric") %>%
  flatten() %>% .[c("name", "main.temp", "main.humidity", "wind.speed")]
```

    ## $name
    ## [1] "Rio de Janeiro"
    ## 
    ## $main.temp
    ## [1] 24.24
    ## 
    ## $main.humidity
    ## [1] 83
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
    ## 2   26.926       4954         ETHF         275.15
    ## 3   69.579       4910         EDLP         278.15
    ## 4   89.149      73733    Uwe Kruse         278.55
    ## 5   93.344 1460732694        hlw31         278.09
    ## 6   97.934 1442728908         AmiH         273.15
    ## 7   98.978       4951         ETHB         278.15

``` r
# get forecast
forecast <- get_forecast("London", units = "metric")

forecast %>% names()
```

    ## [1] "city"    "cod"     "message" "cnt"     "list"

``` r
"name: {{name}}, id: {{id}}, (forcast) rows: {{cnt}}" %$$%
  list(
    name = forecast$city$name,
    id = forecast$city$id,
    cnt = forecast$cnt) %>% cat()
```

    ## name: London, id: 2643743, (forcast) rows: 36

``` r
forecast$list %>% names()
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
    ## 1 2016-12-23 12:00:00     11.02         11.02       7.52
    ## 2 2016-12-23 15:00:00     11.00         11.00       8.85
    ## 3 2016-12-23 18:00:00     11.37         11.37      10.11
    ## 4 2016-12-23 21:00:00      8.53          8.53       6.91
    ## 5 2016-12-24 00:00:00      6.24          6.24       5.55
    ## 6 2016-12-24 03:00:00      5.37          5.37       5.10

``` r
# flatten weather and tidy up column names
forecast %<>% tidy_up()
forecast$list %>% names()
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

# do some magic ...
("{{dt_txt}}h {{temp}} °C, {{wind_speed}} m/s" %$$%
  forecast$list) %>% head(10)
```

    ##  [1] "2016-12-23 12:00:00h 11 °C, 8 m/s" 
    ##  [2] "2016-12-23 15:00:00h 11 °C, 9 m/s" 
    ##  [3] "2016-12-23 18:00:00h 11 °C, 10 m/s"
    ##  [4] "2016-12-23 21:00:00h 9 °C, 7 m/s"  
    ##  [5] "2016-12-24 00:00:00h 6 °C, 6 m/s"  
    ##  [6] "2016-12-24 03:00:00h 5 °C, 5 m/s"  
    ##  [7] "2016-12-24 06:00:00h 6 °C, 5 m/s"  
    ##  [8] "2016-12-24 09:00:00h 6 °C, 6 m/s"  
    ##  [9] "2016-12-24 12:00:00h 9 °C, 7 m/s"  
    ## [10] "2016-12-24 15:00:00h 9 °C, 7 m/s"

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
    ## current weather data for multiple cities: ...
    ## current weather data: .....
    ## mock httr::GET: ...
    ## parse columns: ..
    ## render operator: ...
    ## current weather data from multiple stations: ..
    ## tidy up data: ...
    ## 
    ## DONE ======================================================================
