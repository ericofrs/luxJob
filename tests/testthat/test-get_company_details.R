test_that("Returns a list", {
  result <- get_company_details(10)
  expect_type(result, "list")
})

test_that("Returns a list with two elements", {
  result <- get_company_details(10)
  expect_length(result, 2)
})

test_that("The result contains only one row", {
  result <- get_company_details(10)
  expect_equal(nrow(result$company), 1)
})

test_that("Returns NULL if out of scope", {
  result <- get_company_details(9000)
  expect_null(result$company)
})

test_that("Returns an error if there is no id", {
  expect_error(get_company_details())
})

test_that("Returns an error if the id is not a number", {
  expect_error(get_company_details("10"), regexp = "company_id must be a number.")
})

test_that("Returns an error if the id is not a single number", {
  expect_error(get_company_details(c(10,30)), regexp = "company_id must be a number.")
})
