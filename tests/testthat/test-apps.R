test_that("multiplication works", {

  token <- "nVNaDbXqygpj84oQ"
  username <- "jpmarindiaz"
  orgname <- "cesa"
  slug <- "cesa-profesores-1"
  name <- "Cesa Profesores"
  url <- "https://datasketch.shinyapps.io/cesa-profesores-1"

  create_app_premium(username = username,
                     token = token,
                     orgname = orgname,
                     slug = slug,
                     name = name,
                     url = url,
                     print_query = TRUE)

  slug <- "wikipedia_tables"
  name <- "Extract tables from wikipedia"
  url <- "http://datasketch.shinyapps.io/wikitables_extract"

  create_app_public(username = username,
                     token = token,
                     slug = slug,
                     name = name,
                     url = url,
                     print_query = TRUE)

})
