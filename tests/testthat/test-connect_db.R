test_that("connection works and returns a PqConnection", {
  result <- connect_db()
  expect_s4_class(result, "PqConnection")
})

test_that("Throws an error if env vars are missing", {
  withr::with_envvar(c(PG_DB = NA, PG_HOST = NA, PG_USER = NA, PG_PASSWORD = NA), {
    expect_error(connect_db())
  })
})
