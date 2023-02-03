
#' @export
get_datasets <- function(username = NULL){

  queryname <- "get_datasets"
  variables = list(
    username = load_auth()$DS_AUTH_USERNAME,
    token = load_auth()$DS_AUTH_TOKEN
  )
  run_dsqueries(queryname, variables = variables)

}



