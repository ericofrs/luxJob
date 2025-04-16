#' Verify token
#'
#' Verifies if the token is present in the database.
#'
#' @param token Character. Bearer token to access the database
#'
#' @return Boolean TRUE or FALSE
#' @export
#'
#' @examples
#' \dontrun{
#' verify_token("testtoken")
#' }
verify_token <- function(token) {
  con <- connect_db()
  query <- glue::glue_sql(
    "SELECT * FROM student_erico.api_users WHERE token = {token}",
    .con = con
  )

  response <- DBI::dbGetQuery(con, query)
  result <- nrow(response) != 0
  DBI::dbDisconnect(con)
  return(result)
}
