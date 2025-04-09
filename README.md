# Overview

luxJob is an R package designed to connect to the Luxembourg Jobs database and perform various queries and analyses. It provides tools for accessing and analyzing job market data in Luxembourg, including vacancies, companies, skills, and learning tracks.

# Installation

You can install the development version of luxJob from GitHub with

```r
# install.packages("devtools")
devtools::install_github("ericofrs/luxJob")
```

# Features

- Connect to the Luxembourg Jobs database
- Query and analyze job vacancies
- Explore company information
- Generate book recommendations
- Analyze required skills in the job market
- Search for learning tracks
- Search logs and historical data

# Usage

```r
library(luxJob)

# Connect to the database
con <- connect_db()

# Example: Get recent vacancies in the canton of Luxembourg
get_vacancies(canton="Luxembourg")

# Example: Get company details and its vacancies
get_company_details(10)
```

# Documentation

The package includes detailed documentation for all functions. After installation, you can access the help pages with:

```r
?connect_db
?get_vacancies
```

# License

This project is licensed under the MIT License - see the LICENSE file for details.
