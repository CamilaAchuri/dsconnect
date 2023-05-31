
#' @export
upload_visualization <- function(dv,
                                 auth_username = NULL,
                                 auth_token = NULL,
                                 print_query = TRUE){

  slug <- dv$slug
  name <- dv$name

  auth_username <- auth_username %||% load_auth()$DS_AUTH_USERNAME
  auth_token <- auth_token %||% load_auth()$DS_AUTH_TOKEN

  app <- dv$dsapp
  app <- "cldn3r7q4020508mlh7yjnvkj"

  # Save dv to local dir
  local_path <- file.path(tempdir())

  hv <- hdviz()
  hdviz_write(hv, local_path, username = auth_username)
  local_path <- file.path(local_path, slug)

  # Save local dir to S3
  s3_upload_folder(local_path, username = auth_username)

  # Save to DB

  queryname <- "create_visualization"
  variables = list(
    token =  auth_token,
    sender = auth_username,
    name = name,
    slug = slug,
    username = username,
    app = app
  )
  res <- run_dsqueries(queryname, variables = variables,
                       print_query = print_query)

  unlink(local_path, recursive = TRUE)

  res

}
