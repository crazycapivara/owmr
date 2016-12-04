Installation
------------

    require("devtools")

    install_github("crazycapivara/owmr")

Status
------

Early beta

Usage
-----

    library(owmr)

    ## owmr 0.0.1
    ##     another crazy way to talk to openweathermap's api

    # pass api key
    api_key_ = "your-api-key"
    owmr_settings(api_key = api_key)

    # get current weather
    get_current(city = "London", units = "metric") %>% str()

    ## List of 12
    ##  $ coord     :List of 2
    ##   ..$ lon: num -0.13
    ##   ..$ lat: num 51.5
    ##  $ weather   :'data.frame':  1 obs. of  4 variables:
    ##   ..$ id         : int 800
    ##   ..$ main       : chr "Clear"
    ##   ..$ description: chr "clear sky"
    ##   ..$ icon       : chr "01d"
    ##  $ base      : chr "stations"
    ##  $ main      :List of 5
    ##   ..$ temp    : num 6.18
    ##   ..$ pressure: int 1023
    ##   ..$ humidity: int 75
    ##   ..$ temp_min: int 5
    ##   ..$ temp_max: int 7
    ##  $ visibility: int 10000
    ##  $ wind      :List of 2
    ##   ..$ speed: num 5.7
    ##   ..$ deg  : int 100
    ##  $ clouds    :List of 1
    ##   ..$ all: int 0
    ##  $ dt        : int 1480864800
    ##  $ sys       :List of 6
    ##   ..$ type   : int 1
    ##   ..$ id     : int 5091
    ##   ..$ message: num 0.109
    ##   ..$ country: chr "GB"
    ##   ..$ sunrise: int 1480837752
    ##   ..$ sunset : int 1480866773
    ##  $ id        : int 2643743
    ##  $ name      : chr "London"
    ##  $ cod       : int 200

    # get forecast
    forecast <- get_forecast(city = "London", units = "metric")
