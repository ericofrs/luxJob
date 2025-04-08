#' Get Book Recommendations
#'
#' Returns a list of recommended books. You can filter them by skill.
#'
#' @param param1
#'
#' @returns A data frame with columns 'book_id', 'title', 'author', and 'skill_id'.
#' @export
#'
#' @examples
#' \dontrun{
#' #Get all books
#' get_books()
#'
#' #Get books with specified skill
#' get_books("communication")
#' }
get_books <- function(skill = NULL){
  con <- connect_db()
  if (is.null(skill)) {
      query <- "SELECT br.book_id, br.title, br.author, s.skill_label
                FROM adem.book_recommendations br
                JOIN adem.skills s ON br.skill_id = s.skill_id;"
  } else {
      query <- glue::glue_sql("SELECT br.book_id, br.title, br.author, s.skill_label
                                  FROM adem.book_recommendations br
                                  JOIN adem.skills s ON br.skill_id = s.skill_id
                                  WHERE s.skill_label = {skill};",
                              .con = con
                              )
  }
  output <- DBI::dbGetQuery(con, query)
  DBI::dbDisconnect(con)
  return(output)
}

#' Get Book by ID
#'
#' @param book_id
#'
#' @returns A data frame with one row containing 'book_id', 'title', 'author' and 'skill_id'
#' @export
#'
#' @examples
#' \dontrun{
#' get_book_by_id(10)
#' }
get_book_by_id <- function(book_id = c(1:1000)){
  if (!is.numeric(book_id) || !length(book_id) == 1) {
    stop("Input must be a single number.")
  }
  con <- connect_db()
  query <- glue::glue_sql("SELECT *
                            FROM adem.book_recommendations br
                            WHERE br.book_id = {book_id};",
                          .con = con
  )
  output <- DBI::dbGetQuery(con, query)
  DBI::dbDisconnect(con)
  return(output)
}
