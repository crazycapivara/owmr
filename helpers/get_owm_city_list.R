owm_city_list <- "http://openweathermap.org/help/city_list.txt"
filename <- "data-raw/city_list.txt"

download.file(owm_city_list, filename)
owm_cities <- data.table::fread(filename, encoding = "UTF-8", data.table = F)
owm_cities[is.na(owm_cities)] <- "None"
