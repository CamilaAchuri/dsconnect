#' Read Data Frames from a Database
#'
#' This function retrieves data frames from a specified database in datasketch.
#' It requires authentication details (organization and auth token).
#'
#' @param db A database slug (character string) specifying the database from which to read data frames.
#' @param org A character string specifying the organization associated with the database. Default is NULL.
#' @param authOrg A character string specifying the organization to use for authentication. Default is NULL.
#' @param authToken A character string specifying the authentication token. Default is NULL.
#'
#' @return A data frame containing the requested data from the specified database.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Assuming a valid database connection 'db_conn', org name 'org_name',
#' # authentication org 'auth_org' and authentication token 'auth_token'
#' data <- dsdb_read(db = 'db_slug', org = 'org_name', authOrg = 'auth_org', authToken = 'auth_token')
#' }
dsdb_read <- function(db,
                      org = NULL,
                      authOrg = NULL,
                      authToken = NULL){

  # TODO: validate db exists
  # res <- dsdb_gql_read(db, org = org, authOrg = authOrg, authToken = authToken)
  #
  # db_meta <- res$data$databaseLibraryRead
  # name <- db_meta$name
  # db<- db_meta$slug
  # table_slug <- purrr::map_chr(db_meta$tables, ~ .$slug)[1]

  base_url <- "https://s3.amazonaws.com/uploads.dskt.ch/{org}/{db}"
  db_url <- glue::glue(base_url)
  hb <- hdbase::hdbase_read(db_url)

  hb

}


dsdb_gql_read <- function(db,
                          org = NULL,
                          authOrg = NULL,
                          authToken = NULL){

  authOrg <- authOrg %||% load_auth()$DS_AUTH_USERNAME
  authToken <- authToken %||% load_auth()$DS_AUTH_TOKEN

  queryname <- "db_read"
  variables = list(
    db = db,
    org = org,
    authOrg = authOrg,
    authToken = authToken
  )
  run_dsqueries(queryname, variables = variables, test = FALSE)

}


