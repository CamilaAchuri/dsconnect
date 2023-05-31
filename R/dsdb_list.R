

#' @export
dsdb_list <- function(org = NULL,
                      authOrg = NULL,
                      authToken = NULL){
  res <- dsdb_gql_list(org = org, authOrg = authOrg, authToken = authToken)
  l <- res$data$databaseLibrary

  dbs <- purrr::map(l, purrr::list_flatten) |> dplyr::bind_rows()
  dbs |> dplyr::select(-id)
}

dsdb_gql_list <- function(org = NULL,
                          authOrg = NULL,
                          authToken = NULL){

  authOrg <- authOrg %||% load_auth()$DS_AUTH_USERNAME
  authToken <- authToken %||% load_auth()$DS_AUTH_TOKEN

  queryname <- "db_list"
  variables = list(
    org = org,
    authOrg = authOrg,
    authToken = authToken
  )
  run_dsqueries(queryname, variables = variables, test = TRUE)

}


