
upload_datasets <- function(table, name, slug = NULL){

  # organizationSlug = "ddazal",
  # name = "Lluvias Bogotá 4",
  # slug = "lluvias-bogota-4",
  # file = "mes,lluvia\\nenero,sí"

  if(is.null(slug))
    slug <- make_slug(name)
  file <- readr::format_csv(table)

  queryname <- "upload_dataset"
  variables = list(
    token = load_auth()$DS_AUTH_TOKEN,
    input = list(
      organizationSlug = load_auth()$DS_AUTH_USERNAME,
      name = name,
      slug = slug,
      file = file
    )
  )
  run_dsqueries(queryname, variables = variables)

}

