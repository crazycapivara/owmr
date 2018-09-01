#' Parse weather column to (single) data frame.
#'
#' @param x weather column (NOT name)
#'
#' @return data frame
#' @export
#'
#' @examples\dontrun{
#'    result <- get_forecast("Kassel", units = "metric")$list
#'    weather <- flatten_weather(result$weather)
#'    weather$description %>% print()
#' }
flatten_weather <- function(x) {
  lapply(x, function(df) {
    df[1, ]
  }) %>% do.call(rbind, .)
}
