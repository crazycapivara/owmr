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
# stable
install.packages("owmr")

# unstable
devtools::install_github("crazycapivara/owmr")

# bleeding edge
devtools::install_github("crazycapivara/owmr", ref = "develop")
```

Introduction
------------

See **OpenWeatherMap's** API documentation for optional parameters, which can be passed to all functions fetching weather data via the `...` parameter in R

-   <https://openweathermap.org/api/>

### Setup

``` r
library(owmr)

# first of all you have to set up your api key
owmr_settings("your_api_key")

# or store it in an environment variable called OWM_API_KEY (recommended)
Sys.setenv(OWM_API_KEY = "your_api_key") # if not set globally
```

### Usage

``` r
# get current weather data by city name
(res <- get_current("London", units = "metric") %>%
  flatten()) %>% names()
```

    ##  [1] "coord.lon"           "coord.lat"           "weather.id"         
    ##  [4] "weather.main"        "weather.description" "weather.icon"       
    ##  [7] "base"                "main.temp"           "main.pressure"      
    ## [10] "main.humidity"       "main.temp_min"       "main.temp_max"      
    ## [13] "visibility"          "wind.speed"          "wind.deg"           
    ## [16] "wind.gust"           "all"                 "dt"                 
    ## [19] "sys.type"            "sys.id"              "sys.message"        
    ## [22] "sys.country"         "sys.sunrise"         "sys.sunset"         
    ## [25] "id"                  "name"                "cod"

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
    ## [1] 18.18
    ## 
    ## $weather.description
    ## [1] "light intensity shower rain"

``` r
# ... by city id
(rio <- search_city_list("Rio de Janeiro")) %>%
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
    ## [1] 24.75
    ## 
    ## $main.humidity
    ## [1] 88
    ## 
    ## $wind.speed
    ## [1] 3.6

``` r
# get forecast
forecast <- get_forecast("London", units = "metric")
names(forecast)
```

    ## [1] "cod"     "message" "cnt"     "list"    "city"

``` r
"name: {{name}}, id: {{id}}, (forecast) rows: {{cnt}}" %$$%
  list(
    name = forecast$city$name,
    id   = forecast$city$id,
    cnt  = forecast$cnt) %>% cat()
```

    ## name: London, id: 2643743, (forecast) rows: 40

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
    ## 1 2018-10-11 18:00:00     14.54         16.69       7.46
    ## 2 2018-10-11 21:00:00     14.61         16.23       5.36
    ## 3 2018-10-12 00:00:00     13.17         14.24       4.67
    ## 4 2018-10-12 03:00:00     14.46         15.00       6.61
    ## 5 2018-10-12 06:00:00     15.18         15.18       7.36
    ## 6 2018-10-12 09:00:00     15.87         15.87       7.83

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

    ##  [1] "2018-10-11 18:00:00h 15°C, 7 m/s" 
    ##  [2] "2018-10-11 21:00:00h 15°C, 5 m/s" 
    ##  [3] "2018-10-12 00:00:00h 13°C, 5 m/s" 
    ##  [4] "2018-10-12 03:00:00h 14°C, 7 m/s" 
    ##  [5] "2018-10-12 06:00:00h 15°C, 7 m/s" 
    ##  [6] "2018-10-12 09:00:00h 16°C, 8 m/s" 
    ##  [7] "2018-10-12 12:00:00h 18°C, 9 m/s" 
    ##  [8] "2018-10-12 15:00:00h 18°C, 9 m/s" 
    ##  [9] "2018-10-12 18:00:00h 19°C, 10 m/s"
    ## [10] "2018-10-12 21:00:00h 20°C, 10 m/s"

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
    ## tidy up data: ....
    ## 
    ## DONE ======================================================================
