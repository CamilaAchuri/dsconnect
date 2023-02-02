test_that("Storage works", {

  # Upload single file

  file <- sys_file("sample_files/sample.txt")
  username <- "jpmarindiaz"
  key <- "tmp"
  s3_upload_file(file, username = username, key = key)

  key <- "tmp/tmp.txt"
  s3_upload_file(file, username = username, key = key)

  # Check if object exists

  objects <- s3_list("tmp", username)
  object <- s3_list("tmp/tmp.txt", username)
  object$KeyCount == 1
  object <- s3_list("tmp/non-existing.txt", username)
  object$KeyCount == 0

  # Upload folder

  folder <- "tmp/charts/my-chart"
  s3_upload_folder(folder, username = "jpmarindiaz")

})
