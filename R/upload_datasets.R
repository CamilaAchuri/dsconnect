
upload_datasets <- function(username, token, name, table, slug = NULL){

  # organizationSlug = "ddazal",
  # name = "Lluvias Bogotá 4",
  # slug = "lluvias-bogota-4",
  # file = "mes,lluvia\\nenero,sí"

  if(is.null(slug))
    slug <- make_slug(name)
  file <- readr::format_csv(table)

  queryname <- "upload_dataset"
  variables = list(
    token = token,
    input = list(
      organizationSlug = username,
      name = name,
      slug = slug,
      file = file
    )
  )
  run_dsqueries(queryname, variables = variables)

}

