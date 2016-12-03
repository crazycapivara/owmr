.onLoad <- function(libname, pkgname){
  sprintf("%s %s\n    another crazy way to talk to openweathermap's api\n", pkgname, getNamespaceVersion(pkgname)) %>% cat()
}
