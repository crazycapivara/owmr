library(owmr)

df_cities <- data.table::fread("sandbox/data/cities_df.csv") %>%
  tibble::add_column(g = rep(1:20, 20)[1:nrow(df_cities)])

groups <- dplyr::group_split(df_cities, g)

res <- lapply(groups, function(g) get_current_for_group(g$id) %>% owmr_as_tibble) %>%
  dplyr::bind_rows()
