

s3_upload <- function(path, username, key = NULL){
  if(fs::is_dir(path)){
    upload_s3_folder()
  }
  upload_s3_file(path)
}


s3_upload_file <- function(file, username, key = NULL){

  prefix <- username
  filename <- basename(file)
  if(is_folder(key)){
    key_to <- paste(key, filename, sep = "/")
  }else{
    key_to <- key
  }
  Key <- paste(username, key_to, sep = "/")

  svc <- paws.storage::s3(config = s3_config())
  bucket <- "uploads.dskt.ch"

  Body <- readBin(file, "raw", file.size(file))
  res <- svc$put_object(Bucket = bucket,
                 Key = Key,
                 Body = Body)
  res


}

s3_upload_folder <- function(folder, username){

  if(!fs::is_dir(folder))
    stop("Folder not found")
  key <- basename(folder)

  files <- list.files(folder, full.names = TRUE)
  l <- lapply(files, function(file){
    #file <- files[[1]]

    s3_upload_file(file, username = username, key = key)
  })
  l

}




s3_list <- function(path, username){

  svc <- paws.storage::s3(config = s3_config())
  bucket <- "uploads.dskt.ch"
  svc$list_objects_v2(
    Bucket = bucket,
    Prefix = paste(username, path, sep = "/")
  )

}





s3_config <- function(){
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
  config
}


