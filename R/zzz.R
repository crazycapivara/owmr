#.onLoad <- function(libname, pkgname){
.onAttach <- function(libname, pkgname){
  #sprintf("%s %s\n    another crazy way to talk to openweathermap's api\n", pkgname, getNamespaceVersion(pkgname)) %>% cat()
  packageStartupMessage(
    pkgname, " ", getNamespaceVersion(pkgname), "\n",
    "   another crazy way to talk to OpenWeatherMap's api\n"
  )
}
