test_that("Returns a data.frame", {
  result <- get_learning_tracks()
  expect_s3_class(result, "data.frame")
})

test_that("Returns the expected column names", {
  result <- get_learning_tracks()
  expect_in(colnames(result), c("track_id", "title", "description", "url"))
})

