#' Get Learning Tracks
#'
#' @param skill_id
#'
#' @returns A data frame with columns 'track_id', 'title', 'description' and 'url'.
#' @export
#'
#' @examples
#' \dontrun{
#' #Get all learning tracks
#' get_learning_tracks()
#'
#' #Get learning tracks with specified ESCO skill
#' get_learning_tracks("http://data.europa.eu/esco/skill/d8903406-abc4-48be-9b2e-5d8ddf103bd9")
#' }
get_learning_tracks <-  function(skill_id = NULL){
  con <- connect_db()
  if (is.null(skill_id)) {
    query <- "SELECT br.book_id, br.title, br.author, s.skill_label
              FROM adem.book_recommendations br
              JOIN adem.skills s ON br.skill_id = s.skill_id;"
  } else {
    query <- glue::glue_sql("SELECT lt.*
                              FROM adem.learning_tracks lt
                              JOIN adem.track_skills ts ON ts.track_id = lt.track_id
                              WHERE ts.skill_id = {skill_id};",
                              .con = con
    )
  }
  output <- DBI::dbGetQuery(con, query)
  DBI::dbDisconnect(con)
  return(output)
}


# Create as a helper function?
set_null_if_empty <- function(df) {
  if (is.null(df) || nrow(df) == 0) return(NULL)
  return(df)
}

#' Get learning track and its skills
#'
#' @param track_id
#'
#' @returns A list with two data frames, the first one contains the learning track details and the second one contains the details of the skills associated with that learning track
#' @export
#'
#' @examples
#' \dontrun{
#' get_learning_track_by_id(10)
#' }
get_learning_track_by_id <- function(track_id){
  if (!is.numeric(track_id) || !length(track_id) == 1) {
    stop("track_id must be a number.")
  }
  con <- connect_db()
  query_track <- glue::glue_sql("SELECT *
                                  FROM adem.learning_tracks lt
                                  WHERE lt.track_id = {track_id};",
                                .con = con
  )
  query_skills <- glue::glue_sql("SELECT ts.track_id, ts.skill_id, s.skill_label
                                  FROM adem.track_skills ts
                                  JOIN adem.skills s ON ts.skill_id = s.skill_id
                                  WHERE ts.track_id = {track_id};",
                                  .con = con
  )
  output1 <- DBI::dbGetQuery(con, query_track) |>
    set_null_if_empty()
  output2 <- DBI::dbGetQuery(con, query_skills) |>
    set_null_if_empty()
  result <- list(learning_track = output1, skills = output2)
  DBI::dbDisconnect(con)
  return(result)
}
