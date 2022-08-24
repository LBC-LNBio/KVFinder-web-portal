#' Function that changes the color scheme of biomolecular structure in NGL viewer
#' 
#' @param input shiny input
#' @param output shiny output
#' @param protein_col_scheme_list list of previous selected colors
#' @param protein_rep_list used only to monitor if the scene is a initial or a work scene
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page). 
#' @param scheme_color_list a named list of possible protein color schemes
#' 
#' @import shiny
#' @import NGLVieweR
#'
#' @export
#' 

change_str_color_scheme <- function(input, output, protein_col_scheme_list, protein_rep_list, is_pg2, scheme_color_list){
  if(is_pg2 == TRUE){
    input_protein_color_scheme <- "input_protein_color_scheme_pg2"
    structure <- "structure_pg2"
  } else{
    input_protein_color_scheme <- "input_protein_color_scheme"
    structure <- "structure"
  }
  print("inside_Str_scheme")
  protein_col_scheme_list <- c(protein_col_scheme_list, input[[input_protein_color_scheme]])
  
  #this is a workaround to change the color scheme depending on if it is a initial scene or a work scene 
  NGLVieweR_proxy(structure) %>%
    updateColor("sel2", scheme_color_list[[input[[input_protein_color_scheme]]]])
  NGLVieweR_proxy(structure) %>%
    updateColor("protein_init_cartoon", scheme_color_list[[input[[input_protein_color_scheme]]]])
  
  return(protein_col_scheme_list)
}