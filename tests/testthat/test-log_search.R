test_that("log_search returns message on successful insert with user_id", {
  expect_message(log_search(user_id = 1, query = "Test query"),
                 "Your query has been posted, thank you!")
})

test_that("log_search inserts without user_id and returns warning and message", {
  expect_message(
    expect_warning(log_search(query = "Test query without user_id")))
})

test_that("log_search fails with non-character query input", {
  expect_error(log_search(user_id = 1, query = 1234),
               "Your query must be a text")
})

test_that("log_search fails with vector query", {
  expect_error(log_search(user_id = 1, query = c("query1", "query2")),
               "Your query must be a text")
})

test_that("log_search falls into tryCatch with invalid user_id and returns warning", {
  expect_warning(log_search(user_id = "test", query = "Fall into TryCatch"),
                 regexp = "Failed to insert search log: ")
})
