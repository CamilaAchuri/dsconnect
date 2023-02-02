


config <- function(){
  list(url = "https://app.datasketch.co/.netlify/functions/graphql")
}


start_connection <- function(){
  con <- GraphqlClient$new(url = config()$url)
}
