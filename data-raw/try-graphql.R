
library(ghql)
library(jsonlite)

library(httr)
## WITH HTTR

url <- "https://app.datasketch.co/.netlify/functions/graphql"
my_user <-  "jpmarindiaz"
token <- "nVNaDbXqygpj84oQ"

q <- 'mutation {\n  createFromAPI(token: \"f3rf\", slug: \"ddazal\") {\n    name\n  }\n}'






q <- '
mutation MyQ ($token: String!,
          $input: UploadDataFileToS3Input!
) {
  createFromAPI(token: $token, input: $input) {
    name
  }
}
'





q <- '
mutation {
  createFromAPI(token: "bEh3N6ZtfpAjPcco", input: { organizationSlug: "ddazal", name: "Lluvias Bogotá 3", slug: "lluvias-bogota", file: "mes,lluvia\\nenero,sí" })
  {
    name
  }
}
'

res <- httr::POST(
  url = url,
  # httr::add_headers(
  #   Authorization = paste0(
  #     "Basic ", jsonlite::base64_enc(input = paste0(my_user, ":", my_password))
  #   )
  # ),
  body = list(query = q, variables = list(token = "bEh3N6ZtfpAjPcco",
                                          input = list(
                                            organizationSlug = "ddazal",
                                            name = "Lluvias Bogotá 4",
                                            slug = "lluvias-bogota-4",
                                            file = "mes,lluvia\\nenero,sí"
                                          ))),
  encode = "json",
  verbose = FALSE
)

content(res)

cat(rawToChar(res$request$options$postfields))


## WITH GHQL

url <- "https://app.datasketch.co/.netlify/functions/graphql"
con <- GraphqlClient$new(url = url)

qry <- Query$new()
qry$query('mydata','{ databases(organizationSlug: "ddazal") {id, name }}')
x <- con$exec(qry$queries$mydata)
jsonlite::fromJSON(x)


query_string <- '
query($username: String!){
  databases(organizationSlug: $username) {id, name }
}
'

qry$query('mydata3',query_string)
variables <- list(username = "jpmarindiaz")
result <- con$exec(qry$queries$mydata3, variables = variables)
jsonlite::fromJSON(result)






