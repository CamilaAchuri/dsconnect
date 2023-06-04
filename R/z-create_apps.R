
create_app_premium <- function(username, token, orgname, slug, name, url,
                               type = "premium", print_query = FALSE){

  # token = "dic4aEcVwr97HHh8"
  # username = "ddazal" # org uploading the public app
  # slug = "mapas-colombia" # url slug
  # name = "Mapas Colombia"
  # url = "https://datasketch.shinyapps.io"

  if(is.null(slug))
    slug <- make_slug(name)

  queryname <- "create_app_premium"
  variables = list(
    token = token,
    username = username,
    orgname = orgname,
    slug = slug,
    name = name,
    url = url
  )
  run_dsqueries(queryname, variables = variables, print_query = print_query)
}


create_app_public <- function(username, token, slug, name, url,
                              print_query = FALSE){
  queryname <- "create_app_public"

  variables = list(
    token = token,
    username = username,
    slug = slug,
    name = name,
    url = url
  )

  run_dsqueries(queryname, variables = variables, print_query = print_query)
}
