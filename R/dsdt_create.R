#' Create a Database in Datasketch Cloud Hosting
#'
#' This function creates a new database in the Datasketch Cloud Hosting environment.
#' The operation requires authentication details (organization and auth token).
#'
#' @param slug A character string specifying the slug identifier for the database. Default is NULL.
#' @param name A character string specifying the name of the database. Default is NULL.
#' @param db A database connection object, or a character string specifying the database to create. Default is NULL.
#' @param org A character string specifying the organization associated with the database. Default is NULL.
#' @param authOrg A character string specifying the organization to use for authentication. Default is NULL.
#' @param authToken A character string specifying the authentication token. Default is NULL.
#'
#' @return The result of the database creation operation in the Datasketch Cloud Hosting.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Assuming a valid database connection 'db_conn', org name 'org_name',
#' # authentication org 'auth_org' and authentication token 'auth_token'
#' result <- dsdt_create(slug = 'my_new_db', name = 'My New Database',
#'                       db = db_conn, org = 'org_name', authOrg = 'auth_org',
#'                       authToken = 'auth_token')
#' }
dsdt_create <- function(slug = NULL,
                        name = NULL,
                        db = NULL,
                        org = NULL,
                        authOrg = NULL,
                        authToken = NULL){

  dsdt_gql_create(slug = slug, name = name, db = db,
                  org = org,
                  authOrg = authOrg,
                  authToken = authToken)

}



dsdt_gql_create <- function(slug = NULL,
                        name = NULL,
                        db = NULL,
                        org = NULL,
                        authOrg = NULL,
                        authToken = NULL){

  authOrg <- authOrg %||% load_auth()$DS_AUTH_USERNAME
  authToken <- authToken %||% load_auth()$DS_AUTH_TOKEN
  org <- org %||% authOrg

  queryname <- "dt_create"
  variables = list(
    slug = slug,
    name = name,
    db = db,
    org = org,
    authOrg = authOrg,
    authToken = authToken
  )
  run_dsqueries(queryname, variables = variables, test = TRUE)

}


