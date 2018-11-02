find_cities_by_bbox <- function(bbox = c(12,32,15,37,10), ...) {
  get <- owmr_wrap_get("box/city")
  get(bbox = paste0(box, collapse = ","), ...) %>%
    owmr_parse() %>%
    owmr_class("owmr_box_city")
}
