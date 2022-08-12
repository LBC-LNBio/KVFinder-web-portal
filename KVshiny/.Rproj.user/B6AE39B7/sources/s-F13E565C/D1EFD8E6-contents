#' Change color of biomolecular structure
#' 
#' @param input shiny input
#' @param output shiny output
#' @param protein_col_list list of previous selected colors
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page). 
#' 
#' @import shiny
#' @import NGLVieweR
#'
#' @export
#' 

change_str_color <- function(input, output, protein_col_list, is_pg2){
  if(is_pg2 == TRUE){
    input_protein_color <- "input_protein_color_pg2"
    structure <- "structure_pg2"
  } else{
    input_protein_color <- "input_protein_color"
    structure <- "structure"
  }
    protein_col_list <- c(protein_col_list, input[[input_protein_color]])
    print("inside_str")
    print(protein_col_list)
    if(length(protein_col_list) > 1 & (tail(protein_col_list, n = 1) != "")){ #only change protein color if we change the input color
      print("HereColor")
      NGLVieweR_proxy(structure) %>%
      updateColor("sel2", input[[input_protein_color]])
    }
  return(protein_col_list)
}