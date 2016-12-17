render <- function(template, data){
  # add empty column for correct subsetting of data frames with only one column
  if(ncol(data) == 1) {
    random_name <- tempfile(pattern = "", tmpdir = "") %>%
      sub("/", "", .)
    data[random_name] <- 0L
  }
  sapply(1:nrow(data), function(i){
    whisker::whisker.render(template, data[i, ])
  })
}

`%$%` <- render
