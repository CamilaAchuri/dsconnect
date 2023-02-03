

load_auth <- function(){
  dotenv::load_dot_env()
  list(
    DS_AUTH_USERNAME = Sys.getenv("DS_AUTH_USERNAME"),
    DS_AUTH_TOKEN = Sys.getenv("DS_AUTH_TOKEN")
    )
}


file_ext <- function (x){
  pos <- regexpr("\\.([[:alnum:]]+)$", x)
  ifelse(pos > -1L, substring(x, pos + 1L), "")
}

is_folder <- function(x){
  file_ext(x) == ""
}

sys_file <- function(...){
  system.file(..., package = "dsconnect")
}

#' @export
unix_timestamp <- function(){
  as.integer(as.POSIXct(Sys.time()))
}

#' @export
unix_timestamp_to_date <- function(x){
  as.POSIXct(as.numeric(x), origin="1970-01-01")
}

make_slug <- function (x)
{
  x <- gsub("[^[:alnum:]]", "-", x)
  x <- dstools::remove_accents(tolower(x))
  x <- gsub("-+", "-", x)
  x <- gsub("+[[:punct:]]$", "", x)
  x <- gsub("^-.", "", x)
  x
}



#' @export
`%||%` <- function (x, y) {
  suppressWarnings({
    if (is.empty(x))
      return(y)
    else if (is.null(x) || is.na(x))
      return(y)
    else if (class(x) == "character" && all(nchar(x) == 0))
      return(y)
    else x
  })
}

#' @export
is.empty <- function (x) {
  !as.logical(length(x))
}


