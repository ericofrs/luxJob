#' Get list of skills
#'
#' @param limit
#' @param ordered
#'
#' @returns A dataframe with columns 'skill_id' and 'skill_label', limited number of rows and alphabetically ordered or not.
#' @export
#'
#' @examples
#' \dontrun{
#' #Get list of skills with 10 rows and not ordered
#' get_skills(10)
#'
#' #Get list of skills with 100 rows alphabetically ordered
#' get_skills(100, "yes")
#' }
get_skills <- function(limit = 100, ordered = c("no", "yes")){
  if (!is.numeric(limit) || !length(limit) == 1) {
    stop("Limit must be a number.")
  }
  ordered <- match.arg(ordered)
  con <- connect_db()
  if (ordered == "no") {
    query <- glue::glue_sql("SELECT *
                            FROM adem.skills
                            LIMIT {limit};",
                            .con = con
  )
  }
  else {
    query <- glue::glue_sql("SELECT *
                            FROM adem.skills
                            ORDER BY skill_label
                            LIMIT {limit};",
                            .con = con
    )
  }
  output <- DBI::dbGetQuery(con, query)
  DBI::dbDisconnect(con)
  return(output)
}


#' Get Skill by ESCO skill ID
#'
#' @param skill_id
#'
#' @returns A data frame with columns 'skill_id' and 'skill_label'
#' @export
#'
#' @examples
#' get_skill_by_id("http://data.europa.eu/esco/skill/a276b1ad-c0b7-4b33-899c-0fbfcdbe0eee")
get_skill_by_id <- function(skill_id){
  con <- connect_db()
  query <- glue::glue_sql("SELECT *
                            FROM adem.skills s
                            WHERE s.skill_id = {skill_id};",
                          .con = con
  )
  output <- DBI::dbGetQuery(con, query)
  DBI::dbDisconnect(con)
  return(output)
}
