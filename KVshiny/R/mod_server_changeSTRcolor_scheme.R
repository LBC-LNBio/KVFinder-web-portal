#' Change color scheme of biomolecular structure
#' 
#' @param input shiny input
#' @param output shiny output
#' @param protein_col_scheme_list list of previous selected colors
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page). 
#' 
#' @import shiny
#' @import NGLVieweR
#'
#' @export
#' 

change_str_color_scheme <- function(input, output, protein_col_scheme_list, is_pg2){
  if(is_pg2 == TRUE){
    input_protein_color_scheme <- "input_protein_color_scheme_pg2"
    structure <- "structure_pg2"
  } else{
    input_protein_color_scheme <- "input_protein_color_scheme"
    structure <- "structure"
  }
  protein_col_scheme_list <- c(protein_col_scheme_list, input[[input_protein_color_scheme]])
  NGLVieweR_proxy(structure) %>%
    updateColor("sel2", input[[input_protein_color_scheme]])
  return(protein_col_scheme_list)
}