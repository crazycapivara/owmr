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

    ## owmr 0.6.2
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
get_current("London", units = "metric") %>% unlist()
```

    ##            coord.lon            coord.lat          weather.id1 
    ##              "-0.13"              "51.51"                "741" 
    ##          weather.id2        weather.main1        weather.main2 
    ##                "701"                "Fog"               "Mist" 
    ## weather.description1 weather.description2        weather.icon1 
    ##                "fog"               "mist"                "50n" 
    ##        weather.icon2                 base            main.temp 
    ##                "50n"           "stations"               "6.39" 
    ##        main.pressure        main.humidity        main.temp_min 
    ##               "1024"                "100"                  "5" 
    ##        main.temp_max           visibility           wind.speed 
    ##                  "8"               "2000"                "2.6" 
    ##             wind.deg           clouds.all                   dt 
    ##                 "70"                 "75"         "1482180600" 
    ##             sys.type               sys.id          sys.message 
    ##                  "1"               "5142"             "0.3138" 
    ##          sys.country          sys.sunrise           sys.sunset 
    ##                 "GB"         "1482134604"         "1482162788" 
    ##                   id                 name                  cod 
    ##            "2643743"             "London"                "200"

``` r
# ... by city id
(rio <- with(owm_cities, owm_cities[nm == "Rio de Janeiro", ]))
```

    ##            id             nm       lat      lon countryCode
    ## 13374 3451190 Rio de Janeiro -22.90278 -43.2075          BR

``` r
get_current(rio$id, units = "metric") %>%
  as.data.frame %>% .[1, c("name", "main.temp", "main.humidity", "wind.speed")]
```

    ##             name main.temp main.humidity wind.speed
    ## 1 Rio de Janeiro     32.42            62        5.1

``` r
# get weather data from stations
find_stations_by_geo_point(lat = 51.31667, lon = 9.5, cnt = 7) %>% 
  .[c("distance", "station.id", "station.name", "last.main.temp")]
```

    ##   distance station.id station.name last.main.temp
    ## 1   13.276       4926         EDVK         274.15
    ## 2   26.926       4954         ETHF         272.15
    ## 3   69.579       4910         EDLP         274.15
    ## 4   89.149      73733    Uwe Kruse         274.05
    ## 5   93.344 1460732694        hlw31         273.15
    ## 6   97.934 1442728908         AmiH         273.15
    ## 7   98.978       4951         ETHB         276.15

``` r
# get forecast
forecast <- get_forecast("London", units = "metric")

forecast %>% names()
```

    ## [1] "city"    "cod"     "message" "cnt"     "list"

``` r
sprintf("name: %s, id: %i, (forecast) rows: %i",
        forecast$city$name,
        forecast$city$id,
        forecast$cnt) %>% cat()
```

    ## name: London, id: 2643743, (forecast) rows: 40

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
    ## 1 2016-12-20 00:00:00      5.38          5.38       1.76
    ## 2 2016-12-20 03:00:00      0.51          0.51       1.16
    ## 3 2016-12-20 06:00:00      2.16          2.16       1.46
    ## 4 2016-12-20 09:00:00      1.86          1.86       2.86
    ## 5 2016-12-20 12:00:00      4.02          4.02       2.36
    ## 6 2016-12-20 15:00:00      4.59          4.59       2.43

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
forecast$list %<>% parse_result(list(temp = round, wind_speed = round))

# do some magic ...
("{{dt_txt}}h {{temp}} °C, {{wind_speed}} m/s" %$$%
  forecast$list) %>% head(10)
```

    ##  [1] "2016-12-20 00:00:00h 5 °C, 2 m/s" "2016-12-20 03:00:00h 1 °C, 1 m/s"
    ##  [3] "2016-12-20 06:00:00h 2 °C, 1 m/s" "2016-12-20 09:00:00h 2 °C, 3 m/s"
    ##  [5] "2016-12-20 12:00:00h 4 °C, 2 m/s" "2016-12-20 15:00:00h 5 °C, 2 m/s"
    ##  [7] "2016-12-20 18:00:00h 1 °C, 3 m/s" "2016-12-20 21:00:00h 1 °C, 4 m/s"
    ##  [9] "2016-12-21 00:00:00h 2 °C, 4 m/s" "2016-12-21 03:00:00h 4 °C, 5 m/s"

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

    ## current weather data for multiple cities: ...
    ## current weather data: .....
    ## mock httr::GET: ...
    ## current weather data from multiple stations: ..
    ## 
    ## DONE ======================================================================
