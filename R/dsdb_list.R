#' List Databases
#'
#' This function retrieves a list of databases available to the specified organization.
#' The operation requires authentication details (organization and auth token).
#'
#' @param org A character string specifying the organization associated with the databases. Default is NULL.
#' @param authOrg A character string specifying the organization to use for authentication. Default is NULL.
#' @param authToken A character string specifying the authentication token. Default is NULL.
#'
#' @return A list of databases associated with the specified organization.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Assuming org name 'org_name', authentication org 'auth_org' and authentication token 'auth_token'
#' db_list <- dsdb_list(org = 'org_name', authOrg = 'auth_org', authToken = 'auth_token')
#' }
dsdb_list <- function(org = NULL,
                      authOrg = NULL,
                      authToken = NULL){
  res <- dsdb_gql_list(org = org, authOrg = authOrg, authToken = authToken)
  l <- res$data$databaseLibrary
  if(dstools::is.empty(l)) return()
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


