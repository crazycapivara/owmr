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
  owmr_as_tibble()) %>% names()
```

    ##  [1] "dt_txt"              "temp"                "pressure"           
    ##  [4] "humidity"            "temp_min"            "temp_max"           
    ##  [7] "weather_id"          "weather_main"        "weather_description"
    ## [10] "weather_icon"        "wind_speed"          "wind_deg"           
    ## [13] "clouds_all"          "dt_sunrise_txt"      "dt_sunset_txt"

``` r
res[, 1:6]
```

    ## # A tibble: 1 x 6
    ##   dt_txt               temp pressure humidity temp_min temp_max
    ##   <chr>               <dbl>    <dbl>    <dbl>    <dbl>    <dbl>
    ## 1 2018-10-28 20:50:00  4.22     1017       81        3        6

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
  owmr_as_tibble() %>% .[, 1:6]
```

    ## # A tibble: 1 x 6
    ##   dt_txt               temp pressure humidity temp_min temp_max
    ##   <chr>               <dbl>    <dbl>    <dbl>    <dbl>    <dbl>
    ## 1 2018-10-28 21:00:00  23.2     1014       64       23       24

``` r
# get current weather data for cities around geo point
res <- find_cities_by_geo_point(
  lat = rio$lat,
  lon = rio$lon,
  cnt = 5,
  units = "metric"
) %>% owmr_as_tibble()

idx <- c(names(res[1:6]), "name")
res[, idx]
```

    ## # A tibble: 5 x 7
    ##   dt_txt            temp pressure humidity temp_min temp_max name         
    ##   <chr>            <dbl>    <dbl>    <dbl>    <dbl>    <dbl> <chr>        
    ## 1 2018-10-28 21:0…  23.2     1014       64       23       24 Rio de Janei…
    ## 2 2018-10-28 21:0…  23.2     1014       64       23       24 São Cristóvão
    ## 3 2018-10-28 21:0…  23.2     1014       69       23       24 Botafogo     
    ## 4 2018-10-28 21:0…  23.2     1014       69       23       24 Pavão-Pavaoz…
    ## 5 2018-10-28 21:0…  23.2     1014       64       23       24 Vila Joaniza

``` r
# get forecast
forecast <- get_forecast("London", units = "metric") %>%
  owmr_as_tibble()

forecast[, 1:6]
```

    ## # A tibble: 40 x 6
    ##    dt_txt               temp pressure humidity temp_min temp_max
    ##    <chr>               <dbl>    <dbl>    <dbl>    <dbl>    <dbl>
    ##  1 2018-10-28 21:00:00  2.76    1023.       71     2.76     4.22
    ##  2 2018-10-29 00:00:00  1.64    1021.       90     1.64     2.73
    ##  3 2018-10-29 03:00:00  2.54    1019.       99     2.54     3.27
    ##  4 2018-10-29 06:00:00  1.64    1018.       94     1.64     2   
    ##  5 2018-10-29 09:00:00  4.65    1016.       84     4.65     4.65
    ##  6 2018-10-29 12:00:00  8.44    1013.       77     8.44     8.44
    ##  7 2018-10-29 15:00:00  8.47    1010.       70     8.47     8.47
    ##  8 2018-10-29 18:00:00  5.96    1008.       76     5.96     5.96
    ##  9 2018-10-29 21:00:00  3.57    1005.       87     3.57     3.57
    ## 10 2018-10-30 00:00:00  3.07    1003.       97     3.07     3.07
    ## # ... with 30 more rows

``` r
# apply funcs to some columns
funcs <- list(
  temp = round,
  wind_speed = round
)
forecast %<>% parse_columns(funcs)

# do some templating ...
("{{dt_txt}}h {{temp}}°C, {{wind_speed}} m/s" %$$%
  forecast) %>% head(10)
```

    ##  [1] "2018-10-28 21:00:00h 3°C, 5 m/s" "2018-10-29 00:00:00h 2°C, 4 m/s"
    ##  [3] "2018-10-29 03:00:00h 3°C, 4 m/s" "2018-10-29 06:00:00h 2°C, 4 m/s"
    ##  [5] "2018-10-29 09:00:00h 5°C, 3 m/s" "2018-10-29 12:00:00h 8°C, 4 m/s"
    ##  [7] "2018-10-29 15:00:00h 8°C, 5 m/s" "2018-10-29 18:00:00h 6°C, 4 m/s"
    ##  [9] "2018-10-29 21:00:00h 4°C, 4 m/s" "2018-10-30 00:00:00h 3°C, 4 m/s"

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
devtools::test()
```

    ## Loading owmr

    ## owmr 0.7.4
    ##    another crazy way to talk to OpenWeatherMap's API
    ##    Documentation: type ?owmr or https://crazycapivara.github.io/owmr/
    ##    Issues, notes and bleeding edge: https://github.com/crazycapivara/owmr/

    ## Testing owmr

    ## city list: ..
    ## mock httr::GET current: ....
    ## current weather data for multiple cities: ......
    ## current weather data: ........
    ## _DEPRECATED: W.
    ## mock httr::GET forecast: ......
    ## parse columns: ..
    ## render operator: ...
    ## tidy up data: ...
    ## 
    ## Warnings ------------------------------------------------------------------
    ## 1. tidy up all (@test_deprecated.R#8) - 'tidy_up_' is deprecated.
    ## Use 'owmr_as_tibble' instead.
    ## See help("Deprecated")
    ## 
    ## DONE ======================================================================
