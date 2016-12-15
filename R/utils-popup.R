build_popups <- function(x, ...){
  cmd <- substitute(paste0(...))
  with(x, eval(cmd))
}

`%wrap%` <- function(tag, value){
  sprintf("<%s>%s</%s>", tag, value, tag)
}

strong <- function(value){
  "strong" %wrap% value
}

tag <- list(
  i = function(x) "i" %wrap% x,
  b = function(x) "b" %wrap% x
)

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
