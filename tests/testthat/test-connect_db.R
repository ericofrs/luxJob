test_that("connection works and returns a PqConnection", {
  result <- connect_db()
  expect_s4_class(result, "PqConnection")
})
