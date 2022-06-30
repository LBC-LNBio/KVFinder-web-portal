#' Create work scene to allow changes in NGL viewer
#' 
#' @param input shiny input
#' @param output shiny output
#' @param protein_rep_list list of previous biomolecular structure representations
#' @param protein_col_list list of previous biomolecular structure colors
#' @param protein_col_scheme_list
#' @param result_pdb_list a list returned by check function
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page). 
#' @import shiny
#' @import NGLVieweR
#'
#' @export
#' 

create_work_scene <- function(input, output, protein_rep_list, protein_col_list, protein_col_scheme_list, result_pdb_list, is_pg2){
  if(is_pg2 == TRUE){
    input_protein_rep <- "input_protein_rep_pg2"
    structure <- "structure_pg2"
  } else{
    input_protein_rep <- "input_protein_rep"
    structure <- "structure"
  }
  
  print("inside_work_scene")
  
  #The work scene is always linked to the input_protein_rep input -> It is a start point 
    #If protein_rep_list contains only 1 representations that means that it is a initial scene, so we need to modify the visibility of the structure to invisible
    if(length(protein_rep_list) == 1 ){
      print("case1")
      NGLVieweR_proxy(structure) %>%
        updateVisibility("protein_init_cartoon", value = FALSE)
    }
    #After the initial structure is invisible, we can add a new representation to the current scene 
    
    #print(protein_rep_list)
    print(tail(protein_rep_list, n=1))
    #print(tail(protein_col_scheme_list ,n = 1))
    NGLVieweR_proxy(structure) %>%
      addSelection(tail(protein_rep_list, n=1),
                   param =
                     list(
                       name = "sel2",
                       sele = "protein or nucleic", #this need to be changed to include also nucleic acid 
                       colorScheme = scheme_color_list[[tail(protein_col_scheme_list ,n = 1)]]
                     ))
    #print(tail(protein_col_list ,n = 1))
    #Remove the latest representation

    if(length(protein_rep_list) > 1){
      print("case2")
      NGLVieweR_proxy(structure) %>%
        removeSelection(name = "sel2")
      #Include the new representation
      NGLVieweR_proxy(structure) %>%
        addSelection(tail(protein_rep_list, n = 1),
                     param =
                       list(
                         name = "sel2",
                         sele = paste("NOT (",paste(result_pdb_list$result_cav_names, collapse = " or "),")", sep = ""),
                         colorScheme = scheme_color_list[[tail(protein_col_scheme_list ,n = 1)]]
                         # colorScheme = "residueindex"
                       ))
      
    }
  
}











