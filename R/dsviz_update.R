dsviz_update <- function(viz = NULL,
                         slug = NULL,
                         name= NULL,
                         description = NULL,
                         new_slug = NULL,
                         org = NULL,
                         authOrg = NULL,
                         authToken = NULL){

  # Make sure it is an hdviz

  hdviz <- viz
  if(!is_hdviz(hdviz)){
    hdviz <- hdviz(viz, slug = slug, name = name)
  }

  input <- list(
    name = name,
    description = "descriptionXXXX",
    slug = NULL
  )
  input <- dstools::removeNulls(input)

  # Create db in gql
  res <- dsviz_gql_update(slug = slug,
                          input = input,
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


dsviz_gql_update <- function(slug = NULL,
                             input = NULL,
                             org = NULL,
                             authOrg = NULL,
                             authToken = NULL){

  authOrg <- authOrg %||% load_auth()$DS_AUTH_USERNAME
  authToken <- authToken %||% load_auth()$DS_AUTH_TOKEN
  org <- org %||% authOrg

  queryname <- "dv_update"
  variables = list(
    slug = slug,
    input = input,
    org = org,
    authOrg = authOrg,
    authToken = authToken
  )
  run_dsqueries(queryname, variables = variables, test = TRUE, print_query = TRUE)

}
