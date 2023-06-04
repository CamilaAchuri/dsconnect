#' Create a Visualization in Datasketch Cloud Hosting
#'
#' This function creates a new visualization in the Datasketch Cloud Hosting environment.
#' The operation requires authentication details (organization and auth token).
#'
#' @param viz An object representing the visualization to be created.
#' @param slug A character string specifying the slug identifier for the visualization. Default is NULL.
#' @param name A character string specifying the name of the visualization. Default is NULL.
#' @param org A character string specifying the organization associated with the visualization. Default is NULL.
#' @param authOrg A character string specifying the organization to use for authentication. Default is NULL.
#' @param authToken A character string specifying the authentication token. Default is NULL.
#'
#' @return The result of the visualization creation operation in the Datasketch Cloud Hosting.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Assuming 'viz' as a valid visualization object, org name 'org_name',
#' # authentication org 'auth_org' and authentication token 'auth_token'
#' result <- dsviz_create(viz = viz, name = 'My New Visualization',
#'                       org = 'org_name', authOrg = 'auth_org', authToken = 'auth_token')
#' }
dsviz_create <- function(viz,
                        slug = NULL,
                        name= NULL,
                        org = NULL,
                        authOrg = NULL,
                        authToken = NULL){

  # Make sure it is an hdviz

  hdviz <- viz
  if(!is_hdviz(hdviz)){
    hdviz <- hdviz(viz, slug = slug, name = name)
  }


  # Create db in gql
  res <- dsviz_gql_create(slug = hdviz$slug,
                         name = hdviz$name,
                         #description = b$description,
                         org = org,
                         authOrg = authOrg,
                         authToken = authToken)
  if(!is.null(res$errors)){
    available_viz <- dsviz_list(org)
    if(hdviz$slug %in% available_viz$slug){
      stop("Error: Viz slug already exists")
    } else{
      stop("Error: ", res$errors[[1]]$message)
    }
  }

  viz_meta <- res$data$createVizRemote

  org <- org %||% authOrg
  if(!is.null(viz_meta$id)){
    # Upload to S3
    tmpdir <- tempdir()
    hdviz_write(hdviz, tmpdir)
    viz_path <- file.path(tmpdir, hdviz$slug)
    # Save local dir to S3
    s3path <- s3_upload(viz_path, username = org)
    unlink(file.path(tmpdir,hdviz$slug), recursive = TRUE)
  }
  file.path(s3path, hdviz$slug)

}


dsviz_gql_create <- function(slug = NULL,
                         name = NULL,
                         org = NULL,
                         authOrg = NULL,
                         authToken = NULL){

  authOrg <- authOrg %||% load_auth()$DS_AUTH_USERNAME
  authToken <- authToken %||% load_auth()$DS_AUTH_TOKEN
  org <- org %||% authOrg

  queryname <- "dv_create"
  variables = list(
    slug = slug,
    name = name,
    org = org,
    authOrg = authOrg,
    authToken = authToken
  )
  run_dsqueries(queryname, variables = variables, test = TRUE)

}


