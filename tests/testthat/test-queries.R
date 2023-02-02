test_that("Queries works", {

  q_names <- c("user_datasets")
  av_qs <- available_dsqueries()
  expect_equal(q_names, av_qs)

  qs <- dsqueries()



})
