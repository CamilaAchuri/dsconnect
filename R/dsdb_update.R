

dsdb_update <- function(slug = NULL,
                        name = NULL,
                        db = NULL,
                        org = NULL,
                        authOrg = NULL,
                        authToken = NULL){

  input <- list(
    name = name,
    description = "descriptionXXXX",
    slug = NULL
  )
  input <- dstools::removeNulls(input)

  dsdb_gql_update(slug = slug, input = input,
                  org = org,
                  authOrg = authOrg,
                  authToken = authToken)

}



dsdb_gql_update <- function(slug = NULL,
                            input = NULL,
                            org = NULL,
                            authOrg = NULL,
                            authToken = NULL){

  authOrg <- authOrg %||% load_auth()$DS_AUTH_USERNAME
  authToken <- authToken %||% load_auth()$DS_AUTH_TOKEN
  org <- org %||% authOrg

  queryname <- "db_update"
  variables = list(
    slug = slug,
   input = input,
    org = org,
    authOrg = authOrg,
    authToken = authToken
  )
  run_dsqueries(queryname, variables = variables, test = TRUE)

}


