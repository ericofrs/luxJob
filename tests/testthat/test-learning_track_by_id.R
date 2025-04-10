test_that("Returns a list", {
  result <- get_learning_track_by_id(10)
  expect_type(result, "list")
})
