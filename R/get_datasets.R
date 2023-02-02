
#' @export
get_datasets <- function(username, token, con = NULL){

  queryname <- "get_datasets"
  variables = list(
    username = username,
    token = token
  )
  run_dsqueries(queryname, variables = variables)

}



