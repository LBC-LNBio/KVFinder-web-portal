% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mod_server_pdbProcess.R
\name{pdb_process}
\alias{pdb_process}
\title{Function that process the uploaded or fetched PDB. This function is called in mod_server_submitJob module.}
\usage{
pdb_process(input, output, get_nonstand, mode, session)
}
\arguments{
\item{input}{shiny input}

\item{output}{shiny output}

\item{get_nonstand}{vector of non-standard residues from the input PDB}

\item{mode}{select between "upload" or "fetch" modes}

\item{session}{}
}
\description{
Function that process the uploaded or fetched PDB. This function is called in mod_server_submitJob module.
}
