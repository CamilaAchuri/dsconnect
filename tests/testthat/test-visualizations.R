test_that("multiplication works", {

  library(ggplot2)
  gg <- ggplot(cars, aes(speed, dist)) + geom_point()
  gg

  dv <- dsviz(gg, name = "My chart", dsapp = "simple-charts",
              username = "jpmarindiaz")

  path <- "tmp/chart2"
  dsviz_write(dv, path, username = "jpmarindiaz")



})
