test_that("Returns a data.frame", {
  result <- get_books()
  expect_s3_class(result, "data.frame")
})

test_that("Returns the expected column names", {
  result <- get_books()
  expect_equal(colnames(result), c("book_id", "title", "author", "skill_label"))
})
