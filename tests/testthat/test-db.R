test_that("db_list", {

  httr::GET("http://192.168.87.97:8080")

  dsdb_list(org = "erinpetenko")
  dsdb_list(org = "ddazal")




})


test_that("db_create and read",{

  b <- list(cars4 = cars, iris = iris)
  org <- "test"
  dsdb_create(b, slug = "b11", org = org)


  db <- "b11"
  cars_iris <- dsdb_read(org = "test", db = db)

  cars_iris$hdtables_slugs()
  hdbase_hdtables(hb)



  dsdb_gql_create(slug = "temp", name = "db-name", org = "test")
  dsdb_gql_create(slug = "db-slug", name = "db-name", org = "wikipedia")




  dsdb_create(slug = "db-slug", name = "db-name")
  dsdb_create(slug = "db-slug", name = "db-name", org = "ddazal") # Error

  dsdb_create(slug = "db-slug", name = "db-name", org = "wikipedia")


  dsdt_create(slug = "dt-slug", name = "dt-name", org = "wikipedia",
              db = "db-slug")

  dsdt_create(slug = "dt-slug", name = "dt-name2", org = "wikipedia",
              db = "db-slug")

})


test_that("db_read", {

  dsdb_read("ddazal", db = "anime")
  dsdb_read(org = "redwoodjs", db = "redwoodjs-startups")

  dbs <- dsdb_list(org = "test")

  db <- "db-cars"
  cars <- dsdb_read(org = "test", db = "db-cars")




})




