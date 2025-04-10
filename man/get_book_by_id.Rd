% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/book_recommendations.R
\name{get_book_by_id}
\alias{get_book_by_id}
\title{Get Book by ID}
\usage{
get_book_by_id(book_id = c(1:1000))
}
\arguments{
\item{book_id}{Integer. Filter the list for the book_id.}
}
\value{
A data frame with one row containing 'book_id', 'title', 'author' and 'skill_id'
}
\description{
Returns the book selected by its ID.
}
\examples{
\dontrun{
get_book_by_id(10)
}
}
