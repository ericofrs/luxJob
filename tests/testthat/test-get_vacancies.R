test_that("Returns a data.frame.", {
  result <- get_vacancies()
  expect_s3_class(result, "data.frame")
})

test_that("Returns the expected column names.", {
  result <- get_vacancies()
  expect_in(colnames(result), c("vacancy_id", "company_id", "canton", "occupation", "year", "month"))
})

test_that("Returns a data.frame, even if limit is set to Infinite.", {
  result <- get_vacancies(limit=Inf)
  expect_s3_class(result, "data.frame")
})

test_that("The filtered data.frame is smaller than the complete one.", {
  result_full <- get_vacancies(limit=Inf)
  result_filtered <- get_vacancies(canton="Luxembourg", limit=Inf)
  expect_gt(nrow(result_full), nrow(result_filtered))
})

