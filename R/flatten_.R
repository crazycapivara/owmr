#' Flatten nested data frames.
#'
#' Wraps \code{\link[tidyr]{unnest}} from package \pkg{tidyr}
#' setting parameter \code{sep = "."} by default.
#'
#' @param data data frame containing nested data frames
#' @param sep separator used to combine flattened column names
#' with column names of nested data frames
#'
#' @return flattened data frame
#' @export
#'
#' @seealso \code{\link[tidyr]{unnest}}
#'
#' @examples \dontrun{
#'    find_city("Malaga")$list %>% knock_down()
#' }
knock_down <- function(data, sep = "."){
  tryCatch(
    loadNamespace("tidyr"),
    error = function(e){
      stop("Install 'tidyr' if you want to knock down data frames.", call. = F)
    })
  result <- tidyr::unnest(data, .sep = sep)
  # in case there is more than one row in unnested data frames,
  # keep first row only
  index <- seq(1, nrow(result), nrow(result)/nrow(data))
  result[index, ]
}

knock_down_weather <- function(data, sep = "."){
  weather_column <- "weather"
  weather <- flatten_weather(data[, weather_column])
  names(weather) %<>% paste0(weather_column, sep, . )
  data$weather <- NULL
  cbind(data, weather)
}
