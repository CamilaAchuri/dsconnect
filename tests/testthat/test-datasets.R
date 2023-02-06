test_that("Get datasets", {


  get_datasets()
  get_datasets("ddazal")

})


test_that("Upload datasets", {

  library(tibble)
  table <- tibble(x =1, aab = "abb")



  upload_datasets(username = "ddazal", token = "bEh3N6ZtfpAjPcco",
    name = "Cars 1", table = tab)

  table <- head(mtcars)

  table <- palmerpenguins::penguins
  upload_datasets(table, name = "Palmer penguins")


  upload_datasets(table = table,
                  name = "Cars 11",
                  auth_username = "jpmarindiaz",
                  auth_token = "nVNaDbXqygpj84oQ")


})








