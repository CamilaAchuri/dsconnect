test_that("Get datasets", {


  get_datasets(username)


})


test_that("Upload datasets", {

  library(tibble)
  table <- tibble(x =1, aab = "abb")

  upload_datasets(username = "ddazal", token = "bEh3N6ZtfpAjPcco",
    name = "Cars 1", table = tab)

  table <- head(mtcars)

  upload_datasets(username = "jpmarindiaz", token = "nVNaDbXqygpj84oQ",
                  name = "Cars 1", table = table)


})








