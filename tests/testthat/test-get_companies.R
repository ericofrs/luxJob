test_that("Returns a data.frame.", {
  result <- get_companies()
  expect_s3_class(result, "data.frame")
})

test_that("Returns the expected column names.", {
  result <- get_companies()
  expect_in(colnames(result), c("company_id", "name", "sector"))
})
