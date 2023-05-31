


#' @export
dsdb_read <- function(db,
                      org = NULL,
                      authOrg = NULL,
                      authToken = NULL){

  res <- dsdb_gql_read(db, org = org, authOrg = authOrg, authToken = authToken)

  db_meta <- res$data$databaseLibraryRead
  name <- db_meta$name
  db<- db_meta$slug
  table_slug <- purrr::map_chr(db_meta$tables, ~ .$slug)[1]

  #base_url <- "https://s3.amazonaws.com/uploads.dskt.ch/{org}/{db}"
  #hdbase::hdbase_read(base_url)

  base_url <- "https://s3.amazonaws.com/uploads.dskt.ch/{org}/{db}/{table_slug}.csv"
  data_url <- glue::glue(base_url)
  vroom::vroom(data_url, show_col_types = FALSE)


}



#' @export
dsdb_gql_read <- function(db,
                          org = NULL,
                          authOrg = NULL,
                          authToken = NULL){

  authOrg <- authOrg %||% load_auth()$DS_AUTH_USERNAME
  authToken <- authToken %||% load_auth()$DS_AUTH_TOKEN

  queryname <- "db_read"
  variables = list(
    db = db,
    org = org,
    authOrg = authOrg,
    authToken = authToken
  )
  run_dsqueries(queryname, variables = variables, test = TRUE)

}


