test_that("Returns a data.frame.", {
  result <- get_skills()
  expect_s3_class(result, "data.frame")
})

test_that("Returns the expected column names.", {
  result <- get_skills()
  expect_in(colnames(result), c("skill_id", "skill_label"))
})
