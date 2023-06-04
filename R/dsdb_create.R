#' Create a Database Object or Data Frames in a Database
#'
#' This function creates a new database object of type `hdbase` or, if 'b' is a named list of
#' data frames, it creates these data frames in the specified database. The operation requires
#' authentication details (organization and auth token).
#'
#' @param b An object of type `hdbase` or a named list of data frames to create in the database.
#' @param slug A character string specifying the slug identifier for the database. Default is NULL.
#' @param name A character string specifying the name of the database. Default is NULL.
#' @param org A character string specifying the organization associated with the database. Default is NULL.
#' @param authOrg A character string specifying the organization to use for authentication. Default is NULL.
#' @param authToken A character string specifying the authentication token. Default is NULL.
#'
#' @return The newly created database object or the result of the creation of data frames in the database.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Assuming 'b' as a hdbase object or a named list of data frames,
#' # org name 'org_name', authentication org 'auth_org' and authentication token 'auth_token'
#' result <- dsdb_create(b = b, org = 'org_name', authOrg = 'auth_org', authToken = 'auth_token')
#' }
dsdb_create <- function(b,
                        slug = NULL,
                        name= NULL,
                        org = NULL,
                        authOrg = NULL,
                        authToken = NULL){

  # Make sure it is an hdbase

  hb <- b
  if(!is_hdbase(hb)){
    hb <- hdbase(b, slug = slug, name = name)
  }

  # Create db in gql
  res <- dsdb_gql_create(slug = hb$slug,
                         name = hb$name,
                         #description = b$description,
                         org = org,
                         authOrg = authOrg,
                         authToken = authToken)
  if(!is.null(res$errors)){
    available_dbs <- dsdb_list(org)
    if(hb$slug %in% available_dbs$slug){
      stop("Error: db slug already exists")
    } else{
      stop("Error: ", res$errors[[1]]$message)
    }
  }
  db_meta <- res$data$createDatabaseRemote

  # Create dt in gql

  res_dts <- purrr::walk(hb$hdtables_slugs(), function(t){
    res_dt <- dsdt_create(slug = t,
                          name = hb$hdtables[[t]]$name,
                          org = org,
                          db = hb$slug)
    res_dt
  })


  org <- org %||% authOrg
  if(!is.null(db_meta$id)){
    # Upload to S3
    tmpdir <- tempdir()
    hdbase_write(hb, tmpdir)
    db_path <- file.path(tmpdir, hb$slug)
    # Save local dir to S3
    s3path <- s3_upload(db_path, username = org)
    unlink(file.path(tmpdir, hb$slug), recursive = TRUE)
  }
  file.path(s3path, hb$slug)
}

dsdb_gql_create <- function(slug = NULL,
                            name= NULL,
                            org = NULL,
                            authOrg = NULL,
                            authToken = NULL){

  authOrg <- authOrg %||% load_auth()$DS_AUTH_USERNAME
  authToken <- authToken %||% load_auth()$DS_AUTH_TOKEN
  org <- org %||% authOrg

  queryname <- "db_create"
  variables = list(
    slug = slug,
    name = name,
    org = org,
    authOrg = authOrg,
    authToken = authToken
  )
  run_dsqueries(queryname, variables = variables, test = TRUE)

}



