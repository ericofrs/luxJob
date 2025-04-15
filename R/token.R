#' Verify token
#'
#' Verifies if the token is present in the database.
#'
#' @param token Character. Bearer token to access the database
#' @param schema Character. Optional the schema in the database
#'
#' @return Boolean TRUE or FALSE
#' @export
#'
#' @examples
#' \dontrun{
#' verify_token("testtoken")
#' }
verify_token <- function(token, schema = 'student_erico') {
  con <- connect_db()
  query <- glue::glue(
    "SELECT * FROM {schema}.api_users WHERE username = 'admin'",
    .con = con
  )

  response <- DBI::dbGetQuery(con, query)
  result <- token == response$token
  DBI::dbDisconnect(con)
  return(result)
}
