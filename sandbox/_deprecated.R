# Not supported anymore

# get weather data from stations
find_stations_by_geo_point(lat = 51.31667, lon = 9.5, cnt = 7) %>%
  .[c("distance", "station.id", "station.name", "last.main.temp")]
