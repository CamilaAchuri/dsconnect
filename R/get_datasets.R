
#' @export
get_datasets <- function(username,
                         auth_username = NULL,
                         auth_token = NULL){

  auth_username <- auth_username %||% load_auth()$DS_AUTH_USERNAME
  auth_token <- auth_token %||% load_auth()$DS_AUTH_TOKEN

  queryname <- "get_datasets"
  variables = list(
    username = auth_username,
    token = auth_token
  )
  run_dsqueries(queryname, variables = variables)

}



