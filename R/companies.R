#' Get list of companies
#'
#' @param limit
#'
#' @returns A dataframe with columns 'company_id', 'name' and 'sector' with limited number of rows.
#' @export
#'
#' @examples
#' \dontrun{
#' get_companies(10)
#' }

get_companies <- function(limit = 100){
  if (!is.numeric(limit) || !length(limit) == 1) {
    stop("Limit must be a number.")
  }
  con <- connect_db()
  query <- glue::glue_sql("SELECT *
                          FROM adem.companies
                          LIMIT {limit};",
                          .con = con
                          )

  output <- DBI::dbGetQuery(con, query)
  DBI::dbDisconnect(con)
  return(output)
}

# Create as a helper function?
set_null_if_empty <- function(df) {
  if (is.null(df) || nrow(df) == 0) return(NULL)
  return(df)
}

#' Get company and its vacancies
#'
#' @param company_id
#'
#' @returns A list with two data frames, the first one contains the company details and the second contains the details of the vacancies associated with that company.
#' @export
#'
#' @examples#' \dontrun{
#' get_company_details(10)
#' }
get_company_details <- function(company_id){
  if (!is.numeric(company_id) || !length(company_id) == 1) {
    stop("company_id must be a number.")
  }
  con <- connect_db()
  query_company <- glue::glue_sql("SELECT *
                            FROM adem.companies c
                            WHERE c.company_id = {company_id};",
                          .con = con
  )
  query_vacancies <- glue::glue_sql("SELECT *
                                      FROM adem.vacancies v
                                      WHERE v.company_id = {company_id};",
                                   .con = con
  )
  output1 <- DBI::dbGetQuery(con, query_company) |>
    set_null_if_empty()
  output2 <- DBI::dbGetQuery(con, query_vacancies) |>
    set_null_if_empty()
  result <- list(company = output1, vacancies = output2)
  DBI::dbDisconnect(con)
  return(result)
}
