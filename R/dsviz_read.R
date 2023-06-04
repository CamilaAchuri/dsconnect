

#' @export
dsviz_read <- function(slug = NULL,
                         name = NULL,
                         org = NULL,
                         authOrg = NULL,
                         authToken = NULL){

  authOrg <- authOrg %||% load_auth()$DS_AUTH_USERNAME
  authToken <- authToken %||% load_auth()$DS_AUTH_TOKEN
  org <- org %||% authOrg

  queryname <- "dv_read"
  variables = list(
    slug = slug,
    name = name,
    org = org,
    authOrg = authOrg,
    authToken = authToken
  )
  run_dsqueries(queryname, variables = variables, test = TRUE)

}


