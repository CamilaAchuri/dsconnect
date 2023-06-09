

dsqueries <- function(){
  qry <- ghql::Query$new()

  ## Databases

  db_list <- '
  query($authOrg: String!, $authToken: String!, $org: String) {
  databaseLibrary(authOrg: $authOrg, authToken: $authToken, org: $org) {
    id
    name
    slug
    tables {
      slug
    }
  }
}'

  db_read <- '
  query($authOrg: String!, $authToken: String!, $org: String, $db: String!) {
  databaseLibraryRead(authOrg: $authOrg, authToken: $authToken, db: $db, org: $org) {
    id
    name
    slug
    tables {
      slug
    }
  }
  }
  '

  db_create <- '

  mutation($authOrg: String!, $authToken: String!, $org: String, $name: String!, $slug: String!){
  createDatabaseRemote(authOrg: $authOrg, authToken: $authToken, name: $name, slug: $slug, org: $org) {
    id
    name
  }
}
  '

# Input: name, description, public, license, provider, locked, slug
db_update <- '
    mutation($authOrg: String!, $authToken: String!, $org: String!,
    $input: UpdateDatabaseInput!, $slug: String!){
  updateDatabaseRemote(authOrg: $authOrg, authToken: $authToken, slug: $slug, org: $org,
  input: $input
  ) {
    id
  }
}

'





dt_list <- '
  query($authOrg: String!, $authToken: String!, $org: String) {
  databaseLibrary(authOrg: $authOrg, authToken: $authToken, org: $org) {
    id
    name
    slug
  }
}'


dt_create <- '

    mutation($authOrg: String!, $authToken: String!, $org: String,
    $name: String!, $slug: String!, $db: String!){
  createTableRemote(authOrg: $authOrg, authToken: $authToken, name: $name,
  slug: $slug, org: $org, db: $db) {
    id
    name
  }
}

  '


dt_update <- '
    mutation($authOrg: String!, $authToken: String!, $org: String!, $db: String!,
    $input: UpdateDataTableInput!, $slug: String!){
  updateTableRemote(authOrg: $authOrg, authToken: $authToken, slug: $slug, org: $org, db:$db,
  input: $input
  ) {
    id
  }
}

'



dv_list <- '
  query($authOrg: String!, $authToken: String!, $org: String) {
  vizLibrary(authOrg: $authOrg, authToken: $authToken, org: $org) {
    id
    slug
    name
  }
}'

dv_read <- '
  query($authOrg: String!, $authToken: String!, $org: String, $slug: String!) {
  vizLibraryRead(authOrg: $authOrg, authToken: $authToken, slug: $slug, org: $org) {
    id
    name
  }
  }
  '

dv_create <- '
    mutation($authOrg: String!, $authToken: String!, $org: String,
    $name: String!, $slug: String!){
  createVizRemote(authOrg: $authOrg, authToken: $authToken, name: $name,
  slug: $slug, org: $org) {
    id
  }
}

  '

dv_create2 <- '
    mutation($authOrg: String!, $authToken: String!, $org: String,
    $name: String!, $slug: String!, $description: String){
  createVizRemote(authOrg: $authOrg, authToken: $authToken, name: $name,
  slug: $slug, org: $org, description:$description) {
    id
  }
}

  '

dv_update <- '
    mutation($authOrg: String!, $authToken: String!, $org: String!,
    $input: UpdateVisualizationInput!, $slug: String!){
  updateVizRemote(authOrg: $authOrg, authToken: $authToken, slug: $slug, org: $org,
  input: $input
  ) {
    id
  }
}

'



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

create_visualization <- '
  mutation($token: String!, $sender: String!,
            $name: String!,$slug: String!,
            $username: String!, $app: String!) {
    addVisualization(
      input: {
        token: $token,
        sender: $sender,
        name: $name,
        slug: $slug,
        organizationSlug: $username,
        app: $app
      }
    ) {
      id
    }
  }
  '



dsqueries <- list(
  db_list = db_list,
  db_read = db_read,
  db_create = db_create,
  db_update = db_update,
  dt_create = dt_create,
  dt_update =dt_update,
  dv_list = dv_list,
  dv_read =dv_read,
  dv_create = dv_create,
  dv_update = dv_update,
  get_datasets = get_datasets,
  upload_dataset = upload_dataset,
  create_app_premium = create_app_premium,
  create_app_public = create_app_public,
  create_visualization = create_visualization
)

dsqueries
}

available_dsqueries <- function(){
  qs <- dsqueries()
  names(qs$queries)
}

run_dsqueries <- function(queryname, variables, print_query = FALSE,
                          test = FALSE){
  qry <- dsqueries()
  if(!queryname %in% names(qry))
    stop("Queryname must be one of: ", paste(names(qry), collapse = ", "))

  if(test){
    url <- "http://192.168.87.97:8911/graphql"
    url <- "https://d00b-186-31-143-155.ngrok-free.app/graphql"
    url <- "http://c3f0-186-31-143-154.ngrok-free.app/graphql"
  }else{
    url <- "https://app.datasketch.co/.netlify/functions/graphql"
    url <- "http://c3f0-186-31-143-154.ngrok-free.app/graphql"
  }

  q <- qry[[queryname]]

  if(print_query){
    message("Query sent: ")
    cat(q)
  }

  # res <- httr::POST(
  #   url = url,
  #   body = list(query = q, variables = variables),
  #   encode = "json",
  #   httr::verbose()
  # )

  res <- httr::POST(
    url = url,
    body = list(query = q, variables = variables),
    encode = "json"
  )
  httr::content(res)

}



