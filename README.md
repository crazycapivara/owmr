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
owmr_settings("your-api-key")

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
    ## [1] 20.2
    ## 
    ## $weather.description
    ## [1] "clear sky"

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
    ## [1] 33.28
    ## 
    ## $main.humidity
    ## [1] 62
    ## 
    ## $wind.speed
    ## [1] 5.7

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
    ## [13] "wind.speed"      "wind.deg"        "sys.pod"        
    ## [16] "rain.3h"

``` r
forecast$list[c("dt_txt", "main.temp", "main.temp_max", "wind.speed")] %>%
  head()
```

    ##                dt_txt main.temp main.temp_max wind.speed
    ## 1 2018-10-10 18:00:00     16.94         18.25       4.31
    ## 2 2018-10-10 21:00:00     15.52         16.51       4.57
    ## 3 2018-10-11 00:00:00     15.64         16.30       4.21
    ## 4 2018-10-11 03:00:00     16.05         16.37       6.16
    ## 5 2018-10-11 06:00:00     16.01         16.01       5.71
    ## 6 2018-10-11 09:00:00     18.12         18.12       5.72

``` r
# flatten weather column and tidy up column names
forecast %<>% tidy_up()
names(forecast$list)
```

    ##  [1] "dt"                  "dt_txt"              "temp"               
    ##  [4] "temp_min"            "temp_max"            "pressure"           
    ##  [7] "sea_level"           "grnd_level"          "humidity"           
    ## [10] "temp_kf"             "clouds_all"          "wind_speed"         
    ## [13] "wind_deg"            "pod"                 "rain_3h"            
    ## [16] "weather_id"          "weather_main"        "weather_description"
    ## [19] "weather_icon"

``` r
# apply funcs to some columns  
forecast$list %<>% parse_columns(list(temp = round, wind_speed = round))

# do some templating ...
("{{dt_txt}}h {{temp}}°C, {{wind_speed}} m/s" %$$%
  forecast$list) %>% head(10)
```

    ##  [1] "2018-10-10 18:00:00h 17°C, 4 m/s" "2018-10-10 21:00:00h 16°C, 5 m/s"
    ##  [3] "2018-10-11 00:00:00h 16°C, 4 m/s" "2018-10-11 03:00:00h 16°C, 6 m/s"
    ##  [5] "2018-10-11 06:00:00h 16°C, 6 m/s" "2018-10-11 09:00:00h 18°C, 6 m/s"
    ##  [7] "2018-10-11 12:00:00h 21°C, 7 m/s" "2018-10-11 15:00:00h 21°C, 8 m/s"
    ##  [9] "2018-10-11 18:00:00h 17°C, 7 m/s" "2018-10-11 21:00:00h 16°C, 5 m/s"

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
