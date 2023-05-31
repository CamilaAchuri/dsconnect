

#' @export

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


