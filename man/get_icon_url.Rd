% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/settings.R
\name{get_icon_url}
\alias{get_icon_url}
\title{Get icon url.}
\usage{
get_icon_url(icon)
}
\arguments{
\item{icon}{icon name as returned by owm}
}
\value{
icon url
}
\description{
Get icon url.
}
\examples{
\dontrun{
   forecast <- get_forecast("London")$list
   weather <- flatten_weather(forecast$weather)
   icons <- get_icon_url(weather$icon)
}
}
