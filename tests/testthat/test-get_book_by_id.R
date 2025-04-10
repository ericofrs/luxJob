test_that("Returns a data.frame", {
  result <- get_book_by_id(10)
  expect_s3_class(result, "data.frame")
})

test_that("The result contains only one row", {
  numberrow <- nrow(get_book_by_id(10))
  expect_equal(numberrow, 1)
})
