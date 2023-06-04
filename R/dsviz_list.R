#' List Visualizations
#'
#' This function retrieves a list of visualizations available to the specified organization
#' in the Datasketch Cloud Hosting environment. The operation requires authentication details
#' (organization and auth token).
#'
#' @param org A character string specifying the organization associated with the visualizations. Default is NULL.
#' @param authOrg A character string specifying the organization to use for authentication. Default is NULL.
#' @param authToken A character string specifying the authentication token. Default is NULL.
#'
#' @return A list of visualizations associated with the specified organization.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Assuming org name 'org_name', authentication org 'auth_org' and authentication token 'auth_token'
#' viz_list <- dsviz_list(org = 'org_name', authOrg = 'auth_org', authToken = 'auth_token')
#' }
dsviz_list <- function(org = NULL,
                      authOrg = NULL,
                      authToken = NULL){
  res <- dsviz_gql_list(org = org, authOrg = authOrg, authToken = authToken)
  l <- res$data$vizLibrary
  if(dstools::is.empty(l)) return()
  viz <- purrr::map(l, purrr::list_flatten) |> dplyr::bind_rows()
  viz |> dplyr::select(-id)
}



dsviz_gql_list <- function(org = NULL,
                       authOrg = NULL,
                       authToken = NULL){

  authOrg <- authOrg %||% load_auth()$DS_AUTH_USERNAME
  authToken <- authToken %||% load_auth()$DS_AUTH_TOKEN

  queryname <- "dv_list"
  variables = list(
    org = org,
    authOrg = authOrg,
    authToken = authToken
  )
  run_dsqueries(queryname, variables = variables, test = TRUE)

}

