test_that("multiplication works", {

  library(ggplot2)
  gg <- ggplot(cars, aes(speed, dist)) + geom_point()
  gg

  dv <- dsviz(gg, name = "My chart2", dsapp = "simple-charts",
              username = "jpmarindiaz")
  # Write local
  path <- "tmp/chart2"
  dv$slug
  dsviz_write(dv, path, username = "jpmarindiaz")

  # Save to Datasketch
  username <- "jpmarindiaz"
  upload_visualization(dv, "jpmarindiaz")



})
