
#' @export
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

  res_dt <- dsdt_create(slug = hb$hdtables_slugs()[1],
              name = hb$hdtables[[1]]$name,
              org = org,
              db = hb$slug)

  if(!is.null(db_meta$id)){
    # Upload to S3
    tmpdir <- "123456"
    hdbase_write(hb, tmpdir)
    db_path <- file.path(tmpdir, hb$slug)
    # Save local dir to S3
    s3path <- s3_upload(db_path, username = org)
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



