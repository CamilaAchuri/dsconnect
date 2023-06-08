
library(paws.storage)
library(httr)

env <- load_dot_env()
access_key_id <- Sys.getenv("AWS_ACCESS_KEY_ID_AWS")
secret_access_key <- Sys.getenv("AWS_SECRET_ACCESS_KEY_AWS")
Sys.getenv("AWS_REGION")
profile <- ""

endpoint <- NULL
region <- NULL

compact <- function(.x) {
 Filter(length, .x)
}

bucket <- "uploads.dskt.ch"

config <- compact(list(
  credentials = compact(list(
    creds = compact(list(
      access_key_id = access_key_id,
      secret_access_key = secret_access_key
    )
    ),
    profile = profile
  )),
  #endpoint = endpoint,
  region = "us-east-1"
))
svc <- paws.storage::s3(config = config)

svc$list_objects("uploads.dskt.ch", Prefix = "jpmarindiaz")
svc$list_objects_v2(
  Bucket = bucket
)


svc <- paws.storage::s3()

bucket <- "uploads.dskt.ch"

path <- "tmp/index.html"
name <- "jpmarindiaz/index.html"

body <- readBin(path, "raw", file.size(path))
svc$put_object(Bucket = bucket,
               Key = name,
               Body = body)


