

dsqueries <- function(){
  qry <- ghql::Query$new()

  ## DATASETS

  get_datasets <- '
  query($username: String!){
    databases(organizationSlug: $username) {id, name }
  }'

  upload_dataset <-  '
  mutation ($token: String!,
                $input: UploadDataFileToS3Input!
  ) {
    createFromAPI(token: $token, input: $input) {
      name
    }
  }
  '

  ## VISUALIZATION



  ## APPS

  create_app_premium <- '
  mutation ($token: String!, $username: String!,
            $orgname: String!, $slug: String!,
            $name: String!, $url: String!){
    uploadApp(input: {
      token: $token,
      username: $username,
      organizationSlug: $orgname,
      slug: $slug,
      name: $name,
      url: $url
    }) {
      id
      name
    }
  }
  '

  create_app_public <- '
  mutation ($token: String!, $username: String!,
            $slug: String!,
            $name: String!, $url: String!){
    uploadPublicApp(input: {
      token: $token,
      username: $username,
      slug: $slug,
      name: $name,
      url: $url
    }) {
      id
      name
    }
  }

  '

  dsqueries <- list(
    get_datasets = get_datasets,
    upload_dataset = upload_dataset,
    create_app_premium = create_app_premium,
    create_app_public = create_app_public
  )

  dsqueries
}

available_dsqueries <- function(){
  qs <- dsqueries()
  names(qs$queries)
}

run_dsqueries <- function(queryname, variables, print_query = FALSE){
  qry <- dsqueries()
  if(!queryname %in% names(qry))
    stop("Queryname must be one of: ", paste(names(qry$queries), collapse = ", "))

  url <- "https://app.datasketch.co/.netlify/functions/graphql"

  q <- qry[[queryname]]

  if(print_query){
    message("Query sent: ")
    cat(q)
  }

  res <- httr::POST(
    url = url,
    # httr::add_headers(
    #   Authorization = paste0(
    #     "Basic ", jsonlite::base64_enc(input = paste0(my_user, ":", my_password))
    #   )
    # ),
    body = list(query = q, variables = variables),
    encode = "json"
  )

  httr::content(res)


}



