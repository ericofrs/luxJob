test_that("Returns a list", {
  result <- get_learning_track_by_id(10)
  expect_type(result, "list")
})

test_that("Returns a list with two elements", {
  result <- get_learning_track_by_id(10)
  expect_length(result, 2)
})

test_that("The result contains only one row", {
  result <- get_learning_track_by_id(10)
  expect_equal(nrow(result$learning_track), 1)
})

test_that("The result contains only one row", {
  result <- get_learning_track_by_id(9000)
  expect_null(result$learning_track)
})
