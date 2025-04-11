test_that("Returns a list", {
  result <- get_vacancy_by_id(917152540)
  expect_type(result, "list")
})

test_that("Returns a list with two elements", {
  result <- get_vacancy_by_id(917152540)
  expect_length(result, 2)
})

test_that("The result contains only one row", {
  result <- get_vacancy_by_id(917152540)
  expect_equal(nrow(result$vacancy), 1)
})

test_that("Returns NULL if out of scope", {
  result <- get_vacancy_by_id(10)
  expect_null(result$vacancy)
})

test_that("Returns an error if there is not id", {
  expect_error(get_vacancy_by_id())
})

test_that("Returns an error if the id is not a number", {
  expect_error(get_vacancy_by_id("10"))
})

test_that("Returns an error if the id is not a single number", {
  expect_error(get_vacancy_by_id(c(10,30)))
})
