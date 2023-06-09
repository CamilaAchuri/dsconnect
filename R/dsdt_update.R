
dsdt_update <- function(slug = NULL,
                        name = NULL,
                        db = NULL,
                        new_slug = NULL,
                        org = NULL,
                        authOrg = NULL,
                        authToken = NULL){

  input <- list(
    name = name,
    description = "descriptionXXXX",
    license = NULL,
    slug = new_slug,
    tags = NULL,
    sources = NULL,
    public = NULL,
    deleted = NULL,
    locked = NULL,
    slug = NULL
  )
  input <- dstools::removeNulls(input)

  dsdt_gql_update(slug = slug, input = input,
                  db = db,
                  org = org,
                  authOrg = authOrg,
                  authToken = authToken)

}



dsdt_gql_update <- function(slug = NULL,
                            input = NULL,
                            db = NULL,
                            org = NULL,
                            authOrg = NULL,
                            authToken = NULL){

  authOrg <- authOrg %||% load_auth()$DS_AUTH_USERNAME
  authToken <- authToken %||% load_auth()$DS_AUTH_TOKEN
  org <- org %||% authOrg

  queryname <- "dt_update"
  variables = list(
    slug = slug,
    input = input,
    db = db,
    org = org,
    authOrg = authOrg,
    authToken = authToken
  )
  run_dsqueries(queryname, variables = variables, test = TRUE)

}
