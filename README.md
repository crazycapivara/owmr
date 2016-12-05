OpenWeatherMap api wrapper for R
================

Installation
------------

``` r
require("devtools")

install_github("crazycapivara/owmr")
```

Status
------

Beta

Usage
-----

``` r
library(owmr)
```

    ## owmr 0.2.0
    ##    another crazy way to talk to OpenWeatherMap's api

``` r
# pass api key
api_key_ = "your-api-key"
owmr_settings(api_key = api_key)

# get current weather by city name
get_current("London", units = "metric") %>% str()
```

    ## List of 12
    ##  $ coord     :List of 2
    ##   ..$ lon: num -0.13
    ##   ..$ lat: num 51.5
    ##  $ weather   :'data.frame':  2 obs. of  4 variables:
    ##   ..$ id         : int [1:2] 701 741
    ##   ..$ main       : chr [1:2] "Mist" "Fog"
    ##   ..$ description: chr [1:2] "mist" "fog"
    ##   ..$ icon       : chr [1:2] "50n" "50n"
    ##  $ base      : chr "stations"
    ##  $ main      :List of 5
    ##   ..$ temp    : num 2.34
    ##   ..$ pressure: int 1025
    ##   ..$ humidity: int 100
    ##   ..$ temp_min: int -1
    ##   ..$ temp_max: int 5
    ##  $ visibility: int 3500
    ##  $ wind      :List of 2
    ##   ..$ speed: num 1.5
    ##   ..$ deg  : int 20
    ##  $ clouds    :List of 1
    ##   ..$ all: int 36
    ##  $ dt        : int 1480971000
    ##  $ sys       :List of 6
    ##   ..$ type   : int 1
    ##   ..$ id     : int 5091
    ##   ..$ message: num 0.0034
    ##   ..$ country: chr "GB"
    ##   ..$ sunrise: int 1480924244
    ##   ..$ sunset : int 1480953145
    ##  $ id        : int 2643743
    ##  $ name      : chr "London"
    ##  $ cod       : int 200

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
    ## "Rio de Janeiro"          "22.29"

``` r
# ... by coordinates
get_current(lon = rio$lon, lat = rio$lat) %>%
  unlist() %>% .[c("sys.sunrise", "sys.sunset")] %>%
  as.numeric() %>% as.POSIXct(origin = "1970-01-01")
```

    ## [1] "2016-12-05 08:59:35 CET" "2016-12-05 22:28:42 CET"

``` r
# get weather from stations
find_stations_by_geo_point(lat = 51.31667, lon = 9.5, cnt = 7) %>% 
  .[c("distance", "station.id", "station.name", "last.main.temp")]
```

    ##   distance station.id station.name last.main.temp
    ## 1   13.276       4926         EDVK         269.15
    ## 2   26.926       4954         ETHF         268.15
    ## 3   69.579       4910         EDLP         269.15
    ## 4   89.149      73733    Uwe Kruse         268.35
    ## 5   93.344 1460732694        hlw31         265.68
    ## 6   97.934 1442728908         AmiH         273.15
    ## 7   98.978       4951         ETHB         270.15

``` r
# get forecast
forecast <- get_forecast("London", units = "metric")

forecast %>% names()
```

    ## [1] "city"    "cod"     "message" "cnt"     "list"

``` r
sprintf("%s, %s", forecast$city$name, forecast$city$id)
```

    ## [1] "London, 2643743"

``` r
forecast$cnt
```

    ## [1] 40

``` r
forecast$list %>% nrow()
```

    ## [1] 40

``` r
forecast$list %>% names()
```

    ##  [1] "dt"              "weather"         "dt_txt"         
    ##  [4] "main.temp"       "main.temp_min"   "main.temp_max"  
    ##  [7] "main.pressure"   "main.sea_level"  "main.grnd_level"
    ## [10] "main.humidity"   "main.temp_kf"    "clouds.all"     
    ## [13] "wind.speed"      "wind.deg"        "sys.pod"        
    ## [16] "rain.3h"

``` r
forecast$list[c("dt_txt", "main.temp", "main.temp_max", "wind.speed")] %>% head()
```

    ##                dt_txt main.temp main.temp_max wind.speed
    ## 1 2016-12-06 00:00:00     -0.95         -0.95       1.18
    ## 2 2016-12-06 03:00:00     -1.26         -1.26       1.16
    ## 3 2016-12-06 06:00:00     -1.25         -1.25       1.87
    ## 4 2016-12-06 09:00:00      1.56          1.56       2.60
    ## 5 2016-12-06 12:00:00      8.30          8.30       1.72
    ## 6 2016-12-06 15:00:00      8.88          8.88       1.71
