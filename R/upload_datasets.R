
#' @export
upload_datasets <- function(table, name, slug = NULL,
                            auth_username = NULL,
                            auth_token = NULL){

  # organizationSlug = "ddazal",
  # name = "Lluvias Bogotá 4",
  # slug = "lluvias-bogota-4",
  # file = "mes,lluvia\\nenero,sí"

  auth_username <- auth_username %||% load_auth()$DS_AUTH_USERNAME
  auth_token <- auth_token %||% load_auth()$DS_AUTH_TOKEN

  if(is.null(slug))
    slug <- make_slug(name)
  file <- readr::format_csv(table)

  queryname <- "upload_dataset"
  variables = list(
    token = auth_token,
    input = list(
      organizationSlug = auth_username,
      name = name,
      slug = slug,
      file = file
    )
  )
  run_dsqueries(queryname, variables = variables)

}

