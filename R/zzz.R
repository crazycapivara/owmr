.onLoad <- function(libname, pkgname){
  sprintf("%s %s\n    the craziest way to talk to openweathermap's api\n", pkgname, getNamespaceVersion(pkgname)) %>% cat()
}