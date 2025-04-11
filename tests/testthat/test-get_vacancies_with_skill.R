test_that("Returns a data.frame.", {
  result <- get_vacancies_with_skill()
  expect_s3_class(result, "data.frame")
})

test_that("Returns the expected column names.", {
  result <- get_vacancies_with_skill()
  expect_in(colnames(result), c("vacancy_id", "company_id", "canton", "occupation", "year", "month", "skill_id"))
})

test_that("Returns a data.frame, even if limit is set to Infinite.", {
  result <- get_vacancies_with_skill(limit=Inf)
  expect_s3_class(result, "data.frame")
})

test_that("The filtered data.frame is smaller than the complete one.", {
  result_full <- get_vacancies_with_skill(limit=Inf)
  result_filtered <- get_vacancies_with_skill(canton="Luxembourg", limit=Inf)
  expect_gt(nrow(result_full), nrow(result_filtered))
})
