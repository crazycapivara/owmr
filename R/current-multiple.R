get_current_for_group <- function(city_ids, ...){
  get <- owmr_wrap_get("group")
  get(id = paste(city_ids, collapse = ",")) %>%
    owmr_parse()
}
