#' Get vacancies
#'
#' @param occupation
#' @param company_id
#' @param canton
#' @param limit
#'
#' @returns A data frame with the columns vacancy_id, company_id, occupation, canton, year and month.
#' @export
#'
#' @examples
#' \dontrun{
#' get_vacancies()
#'
#' get_vacancies(canton="Luxembourg")
#' }
get_vacancies <- function(occupation = NULL, company_id = NULL, canton = NULL, limit = 100) {
  con <- connect_db()

  # Start base query
  query <- glue::glue_sql("SELECT v.*
                            FROM adem.vacancies v
                            WHERE 1=1",
                          .con = con)

  # Dynamically add filters if they're not NULL
  if (!is.null(occupation)) {
    query <- glue::glue_sql("{query} AND v.occupation = {occupation}", .con = con)
  }

  if (!is.null(company_id)) {
    query <- glue::glue_sql("{query} AND v.company_id = {company_id}", .con = con)
  }

  if (!is.null(canton)) {
    query <- glue::glue_sql("{query} AND v.canton = {canton}", .con = con)
  }

  # Add LIMIT clause
  query <- glue::glue_sql("{query} LIMIT {limit}", .con = con)

  # Run query
  result <- DBI::dbGetQuery(con, query)
  DBI::dbDisconnect(con)

  return(result)
}



#' Get Vancancies and their skills
#'
#' @param skill_id
#' @param company_id
#' @param canton
#' @param limit
#'
#' @returns A data frame with the columns vacancy_id, company_id, occupation, canton, year, month and skill_id.
#' @export
#'
#' @examples
#' \dontrun{
#' get_vacancies_with_skill()
#'
#' get_vacancies_with_skill(canton="Luxembourg", limit = 10)
#' }
get_vacancies_with_skill <- function(skill_id = NULL, company_id = NULL, canton = NULL, limit = 100) {
  con <- connect_db()
  query <- glue::glue_sql("SELECT v.*, vs.skill_id
                            FROM adem.vacancies v
                            JOIN adem.vacancy_skills vs ON v.vacancy_id = vs.vacancy_id
                            WHERE 1=1",
                            .con = con)

  if (!is.null(skill_id)) {
    query <- glue::glue_sql("{query} AND vs.skill_id = {skill_id}", .con = con)
  }

  if (!is.null(company_id)) {
    query <- glue::glue_sql("{query} AND v.company_id = {company_id}", .con = con)
  }

  if (!is.null(canton)) {
    query <- glue::glue_sql("{query} AND v.canton = {canton}", .con = con)
  }

  query <- glue::glue_sql("{query} LIMIT {limit}", .con = con)

  result <- DBI::dbGetQuery(con, query)
  DBI::dbDisconnect(con)
  return(result)
}

# Create as a helper function?
set_null_if_empty <- function(df) {
  if (is.null(df) || nrow(df) == 0) return(NULL)
  return(df)
}

#' Get vacancy and its skills
#'
#' @param vacancy_id
#'
#' @returns A list with two data frames, the first one contains the vacancy details and the second one contains the skills associated with that vacancy.
#' @export
#'
#' @examples
#' \dontrun{
#' get_vacancy_by_id(917152540)
#' }
get_vacancy_by_id <- function(vacancy_id){
  if (!is.numeric(vacancy_id) || !length(vacancy_id) == 1) {
    stop("vacancy_id must be a number.")
  }
  con <- connect_db()
  query_vacancy <- glue::glue_sql("SELECT v.*
                                    FROM adem.vacancies v
                                    WHERE v.vacancy_id = {vacancy_id};",
                                    .con = con
  )
  query_skill <- glue::glue_sql("SELECT vs.*, s.skill_label
                                  FROM adem.vacancy_skills vs
                                  JOIN adem.skills s ON vs.skill_id = s.skill_id
                                  WHERE vs.vacancy_id = {vacancy_id};",
                                  .con = con
  )
  output1 <- DBI::dbGetQuery(con, query_vacancy) |>
    set_null_if_empty()
  output2 <- DBI::dbGetQuery(con, query_skill) |>
    set_null_if_empty()
  result <- list(vacancy = output1, skills = output2)
  DBI::dbDisconnect(con)
  return(result)
}
