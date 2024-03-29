% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mod_server_changeSTRcolor_scheme.R
\name{change_str_color_scheme}
\alias{change_str_color_scheme}
\title{Function that changes the color scheme of biomolecular structure in NGL viewer}
\usage{
change_str_color_scheme(
  input,
  output,
  protein_col_scheme_list,
  protein_rep_list,
  is_pg2,
  scheme_color_list
)
}
\arguments{
\item{input}{shiny input}

\item{output}{shiny output}

\item{protein_col_scheme_list}{list of previous selected colors}

\item{protein_rep_list}{used only to monitor if the scene is a initial or a work scene}

\item{is_pg2}{logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page).}

\item{scheme_color_list}{a named list of possible protein color schemes}
}
\description{
Function that changes the color scheme of biomolecular structure in NGL viewer
}
