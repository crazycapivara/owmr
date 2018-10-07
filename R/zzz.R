.onAttach <- function(libname, pkgname) {
  api_key_message <- c(
    "\n",
    "It is recommended that you store your api key in an environment variable called OWM_API_KEY.\n"
  )
  if (!identical(Sys.getenv("OWM_API_KEY"), "")) api_key_message <- ""

  packageStartupMessage(
    pkgname, " ", getNamespaceVersion(pkgname), "\n",
    "   another crazy way to talk to OpenWeatherMap's API\n",
    "   Documentation: type ?owmr or https://crazycapivara.github.io/owmr/\n",
    "   Issues, notes and bleeding edge: https://github.com/crazycapivara/owmr/\n",
    api_key_message
  )
}

globalVariables(".")
