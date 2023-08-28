test_that("db_list", {

  httr::GET("http://192.168.87.97:8080")

  dsdb_list(org = "erinpetenko")
  dsdb_list(org = "ddazal")

  db_ddazal <- dsdb_list(org = "ddazal")

  db_jpmarindiaz <- dsdb_list(org = "jpmarindiaz")
  db_jpmarindiaz <- dsdt_list(org = "jpmarindiaz")

  db_fcd <- dsdb_list(org = "fcd")
  dt_fcd <- dsdt_list(org = "fcd")
})


test_that("db_create and read",{

  path_files <- "tmp/banderas-rojas-files"
  today <- as.character(Sys.Date())
  h <- hdbase(path_files, slug = "banderas-rojas",
              name = "Banderas Rojas",
              lazy = FALSE, last_updated = today)
  org <- "fcd"
  dsdb_create(h, slug = "bandera-rojas", org = org)

})


test_that("db_create and read",{

  b <- list(cars4 = cars, iris = iris)
  org <- "test"
  dsdb_create(b, slug = "b111", org = org)

  b <- list(cars4 = cars, iris = iris)
  db <- hdbase(b)
  org <- "test"
  dsdb_create(db, slug = "b111", org = org)


  dsdt_create(slug = "dt-slug", name = "dt-name2", org = "test",
              db = "b111")
  new_slug <- "dt-slug-2"
  dsdt_update(slug = "dt-slug", name = "DT NEW", org = "test",
              new_slug = new_slug,
              db = "b111")



  dsdb_update()



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







