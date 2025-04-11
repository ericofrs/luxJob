test_that("Returns a data.frame", {
  result <- get_skill_by_id("http://data.europa.eu/esco/skill/a276b1ad-c0b7-4b33-899c-0fbfcdbe0eee")
  expect_s3_class(result, "data.frame")
})

test_that("The result contains only one row", {
  numberrow <- nrow(get_skill_by_id("http://data.europa.eu/esco/skill/a276b1ad-c0b7-4b33-899c-0fbfcdbe0eee"))
  expect_equal(numberrow, 1)
})
