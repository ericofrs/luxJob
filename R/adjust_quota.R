#' Adjust API Quota
#'
#' Decreases the quota by 1 for the user identified by a given API token.
#' Ensures the quota does not fall below 0 and throws an error if the token is not found or the quota is already exhausted.
#'
#' @param token Character Representing the API token of the user.
#'
#' @return Returns `TRUE` if the quota was successfully updated.
#' @export
#'
#' @examples
#' \dontrun{
#' adjust_quota("abc123")
#' }
adjust_quota <- function(token) {
  con <- connect_db()

  query <- glue::glue_sql(
    "SELECT quota FROM student_erico.api_users WHERE token = {token}",
    .con = con
  )
  current_quota <- DBI::dbGetQuery(con, query)$quota

  if (length(current_quota) == 0) {
    stop("Token not found in quota table.")
  }

  if (current_quota <= 0) {
    stop("Quota has already been exhausted.")
  }

  new_quota <- max(current_quota - 1, 0)

  # Update the quota
  update_query <- glue::glue_sql(
    "UPDATE student_erico.api_users SET quota = {new_quota} WHERE token = {token}",
    .con = con
  )

  DBI::dbExecute(con, update_query)

  DBI::dbDisconnect(con)

  return(TRUE)
}
