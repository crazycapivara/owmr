Installation
------------

    require("devtools")

    install_github("https://github.com/crazycapivara/owmr.git")

Status
------

Early beta

Usage
-----

    library(owmr)

    ## owmr 0.0.0.9000
    ##     the craziest way to talk to openweathermap's api

    api_key_ = "your-api-key"
    owmr_settings(api_key = api_key)

    get_current(city = "London", units = "metric") %>% head()

    ## $coord.lon
    ## [1] -0.13
    ## 
    ## $coord.lat
    ## [1] 51.51
    ## 
    ## $weather.id
    ## [1] 802
    ## 
    ## $weather.main
    ## [1] "Clouds"
    ## 
    ## $weather.description
    ## [1] "scattered clouds"
    ## 
    ## $weather.icon
    ## [1] "03n"
