
upload_visualization <- function(dv, username){

  slug <- dv$slug
  name <- dv$name
  app <- dv$dsapp

  # Save dv to local dir
  local_path <- file.path(tempdir())
  dsviz_write(dv, local_path, username = username)
  local_path <- file.path(local_path, slug)

  # Save local dir to S3
  s3_upload_folder(local_path, username = username)

  # Save to DB

  queryname <- "create_visualization"
  variables = list(
    token =  load_auth()$DS_AUTH_TOKEN,
    sender = load_auth()$DS_AUTH_USERNAME,
    name = name,
    slug = slug,
    username = username,
    app = app
  )
  res <- run_dsqueries(queryname, variables = variables, print_query = TRUE)

  unlink(local_path, recursive = TRUE)

  res

}
