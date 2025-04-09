#' Insert search log
#'
#' Insert your query in the search log.
#'
#' @param user_id Integer. Optional insert the user_id.
#' @param query Character. Query to be posted in the search log.
#'
#' @returns A message confirming the action.
#' @export
#'
#' @examples
#' \dontrun{
#' # Inserts a query
#' log_search(query="Query test")
#'
#' # Inserts a query with identified user_id
#' log_search(user_id=4, query="Second test")
#' }
log_search <- function(user_id = NULL, query){
  con <- connect_db()
  if(is.null(user_id)) {
    warning("You didn't specified the 'user_id', so your 'user_name' has been generated automatically")
    new_username <- ids::adjective_animal(max_len = 12)
    new_token <- ids::random_id(bytes = 12)
    new_user_query <- glue::glue_sql("INSERT INTO student_erico.api_users (username, token)
                                      VALUES ({new_username}, {new_token})
                                      RETURNING user_id;
                                    ", .con = con)
    user_id <- DBI::dbGetQuery(con, new_user_query)$user_id
  }
  if (!is.character(query) || !length(query) == 1) {
    stop("Your query must be a text, and cannot be a vector.")
  }
  insert_log_query <- glue::glue_sql("INSERT INTO student_erico.search_logs (user_id, query)
                                    VALUES ({user_id}, {query});
                                    ", .con = con)
  tryCatch({
    DBI::dbExecute(con, insert_log_query)
    message("Your query has been posted, thank you!")
  }, error = function(e) {
    warning("Failed to insert search log: ", conditionMessage(e))
  })
  DBI::dbDisconnect(con)
}
