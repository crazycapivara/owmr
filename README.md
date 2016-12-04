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

Early beta

Usage
-----

``` r
library(owmr)
```

    ## owmr 0.0.1
    ##     another crazy way to talk to openweathermap's api

``` r
# pass api key
api_key_ = "your-api-key"
owmr_settings(api_key = api_key)

# get current weather
get_current(city = "London", units = "metric") %>% str()
```

    ## List of 12
    ##  $ coord     :List of 2
    ##   ..$ lon: num -0.13
    ##   ..$ lat: num 51.5
    ##  $ weather   :'data.frame':  1 obs. of  4 variables:
    ##   ..$ id         : int 800
    ##   ..$ main       : chr "Clear"
    ##   ..$ description: chr "clear sky"
    ##   ..$ icon       : chr "01n"
    ##  $ base      : chr "stations"
    ##  $ main      :List of 5
    ##   ..$ temp    : num 4.42
    ##   ..$ pressure: int 1023
    ##   ..$ humidity: int 86
    ##   ..$ temp_min: int 3
    ##   ..$ temp_max: int 6
    ##  $ visibility: int 10000
    ##  $ wind      :List of 2
    ##   ..$ speed: num 5.7
    ##   ..$ deg  : int 90
    ##  $ clouds    :List of 1
    ##   ..$ all: int 0
    ##  $ dt        : int 1480868400
    ##  $ sys       :List of 6
    ##   ..$ type   : int 1
    ##   ..$ id     : int 5091
    ##   ..$ message: num 0.0029
    ##   ..$ country: chr "GB"
    ##   ..$ sunrise: int 1480837756
    ##   ..$ sunset : int 1480866772
    ##  $ id        : int 2643743
    ##  $ name      : chr "London"
    ##  $ cod       : int 200

``` r
# get forecast
forecast <- get_forecast(city = "London", units = "metric")

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

    ## [1] 34

``` r
forecast$list %>% nrow()
```

    ## [1] 34

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
    ## 1 2016-12-04 18:00:00      3.08          3.08       3.98
    ## 2 2016-12-04 21:00:00      1.52          1.52       3.27
    ## 3 2016-12-05 00:00:00      0.37          0.37       2.81
    ## 4 2016-12-05 03:00:00     -1.23         -1.23       2.06
    ## 5 2016-12-05 06:00:00     -1.96         -1.96       1.57
    ## 6 2016-12-05 09:00:00     -0.94         -0.94       2.34
