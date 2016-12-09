# TODO

* put check for api key in wrapper function of get __DONE__
* use `testthat` function instead of `devtools::test()` in helper function to fetch data for tests __DONE__
* document low level functions or exclude from export
* document `owm_cities` dataset __DONE__
* update examples in README file __DONE__
* add documentation via github pages __basic page added__
* refactor `owmr_wrap_get` function __DONE__
* create separate `find_cities_by_geo_point` function (at the moment `find_city` is used for this) __DONE__
* include maps api (OpenWeatherMap tms)
* write tests for forcast responses
* run win builder check to put package to CRAN
* add license file

# Build notes

* found 1 marked UTF-8 string in data
  - `owm_cities$nm[7053] <- Metabetchouan-Lac-a-la-Croix` __ added to helper func generating owm_cities dataset FIXED__
