owm_city_list <- "http://openweathermap.org/help/city_list.txt"
filename <- "data-raw/city_list.txt"

download.file(owm_city_list, filename)
#owm_cities <- data.table::fread(filename, encoding = "UTF-8", data.table = F)
owm_cities <- data.table::fread(filename, data.table = FALSE)
owm_cities[is.na(owm_cities)] <- "None"
owm_cities[7053, ] %>% print
# run lines above in case of wrong encoding
#nm_7053 <- "Metabetchouan-Lac-a-la-Croix"
#owm_cities[7053, ]$nm <- nm_7053
