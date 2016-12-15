popups <- function(data = NULL){
  l = list()
  attr(l, "data") <- data
  l
}

tag_ <- function(popups, name, x){
  if(class(x) == "formula"){
    key <- terms(x) %>% labels()
    x <- attr(popups, "data") %>% .[[key]]
  }
  c(popups, list(name %wrap% x))
}

txt <- function(popups, x){
  c(popups, list(x))
}

create_ <- function(popups){
  do.call(paste0, popups)
}
