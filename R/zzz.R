.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    pkgname, " ", getNamespaceVersion(pkgname), "\n",
    "   another crazy way to talk to OpenWeatherMap's API\n",
    "   Documentation: type ?owmr or https://crazycapivara.github.io/owmr/\n",
    "   Issues, notes and bleeding edge: https://github.com/crazycapivara/owmr/\n\n",
    "   it is recommended that you store your api key in an environment variable\n",
    "   called OWM_API_KEY"
  )

  if (is.null(owmr_key())) {
    message("It is recommended that you store your OWMR API key in an
.Renviron variable called OWMR_KEY.")
  }
}

globalVariables(".")
