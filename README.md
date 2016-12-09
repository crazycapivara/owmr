OpenWeatherMap api wrapper for R
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

    ## owmr 0.5.0
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
    ##              "-0.13"              "51.51"                "721" 
    ##          weather.id2        weather.main1        weather.main2 
    ##                "701"               "Haze"               "Mist" 
    ## weather.description1 weather.description2        weather.icon1 
    ##               "haze"               "mist"                "50n" 
    ##        weather.icon2                 base            main.temp 
    ##                "50n"           "stations"              "10.64" 
    ##        main.pressure        main.humidity        main.temp_min 
    ##               "1024"                 "87"                 "10" 
    ##        main.temp_max           visibility           wind.speed 
    ##                 "11"               "7000"                "3.1" 
    ##            wind.gust           clouds.all                   dt 
    ##                "9.8"                 "75"         "1481314800" 
    ##             sys.type               sys.id          sys.message 
    ##                  "1"               "5091"             "0.0058" 
    ##          sys.country          sys.sunrise           sys.sunset 
    ##                 "GB"         "1481270115"         "1481298689" 
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
  unlist %>% .[c("name", "main.temp")]
```

    ##             name        main.temp 
    ## "Rio de Janeiro"          "27.76"

``` r
# get weather data from stations
find_stations_by_geo_point(lat = 51.31667, lon = 9.5, cnt = 7) %>% 
  .[c("distance", "station.id", "station.name", "last.main.temp")]
```

    ##   distance station.id station.name last.main.temp
    ## 1   13.276       4926         EDVK         277.15
    ## 2   26.926       4954         ETHF         278.15
    ## 3   69.579       4910         EDLP         282.15
    ## 4   89.149      73733    Uwe Kruse         282.75
    ## 5   93.344 1460732694        hlw31         282.40
    ## 6   97.934 1442728908         AmiH         273.15
    ## 7   98.978       4951         ETHB         283.15

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
forecast$list[c("dt_txt", "main.temp", "main.temp_max", "wind.speed")] %>% head()
```

    ##                dt_txt main.temp main.temp_max wind.speed
    ## 1 2016-12-10 00:00:00      9.72         10.21       4.71
    ## 2 2016-12-10 03:00:00     10.34         10.66       4.52
    ## 3 2016-12-10 06:00:00     11.20         11.37       3.95
    ## 4 2016-12-10 09:00:00     11.72         11.72       3.40
    ## 5 2016-12-10 12:00:00     12.04         12.04       2.96
    ## 6 2016-12-10 15:00:00     11.07         11.07       2.41

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
testthat::test_dir("tests/testthat/")
```

    ## current weather data for multiple cities: ...
    ## current weather data: .....
    ## current weather data from multiple stations: ..
    ## 
    ## DONE ======================================================================
