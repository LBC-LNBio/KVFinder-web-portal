#' Function that change background color in NGL viewer
#'
#' @param input shiny input
#' @param output shiny output
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page).
#' @param cav_rep_list
#' @param result_pdb_list
#' 
#' 
#' @import shiny
#' @import NGLVieweR
#'
#' @export
#'

color_cavity_deepth <- function(input, output, is_pg2, cav_rep_list, result_pdb_list) {
  if (is_pg2 == TRUE) {
    input_cavity_deep <- "input_cavity_deep_pg2"
    select_cavity <- "select_cavity_pg2"
    structure <- "structure_pg2"
  } else {
    input_cavity_deep <- "input_cavity_deep"
    select_cavity <- "select_cavity"
    structure <- "structure"
  }
  #print(result_pdb_list$result_toml$MAX_DEPTH)
  #print(max(unlist(result_pdb_list$result_toml$MAX_DEPTH)))
  #NGLVieweR_proxy(structure) %>%
  #  removeSelection(name = tail(cav_rep_list, n = 2)[1])
  # After the initial structure is invisible, we can add a new representation to the current scene
  
  if(input[[input_cavity_deep]] == TRUE){
    if(input[[select_cavity]] == "All"){
    NGLVieweR_proxy(structure) %>%
      addSelection("point",
                   param =
                     list(
                       name = "deepth", # now the created selection is named "sel3"
                       sele = paste(result_pdb_list$result_cav_names, collapse = " or "),
                       colorScheme = 'bfactor',
                       colorScale = 'rainbow',
                       colorReverse = TRUE,
                       colorDomain = c(0.0, max(unlist(result_pdb_list$result_toml$MAX_DEPTH)))
                       #colorScheme = scheme_color_list[[tail(protein_col_scheme_list, n = 1)]]
                     )
      )
  } else {
    NGLVieweR_proxy(structure) %>%
      addSelection("point",
                   param =
                     list(
                       name = "deepth", # now the created selection is named "sel3"
                       sele = input[[select_cavity]],
                       colorScheme = 'bfactor',
                       colorScale = 'rainbow',
                       colorReverse = TRUE,
                       colorDomain = c(0.0, max(unlist(result_pdb_list$result_toml$MAX_DEPTH)))
                       #colorScheme = scheme_color_list[[tail(protein_col_scheme_list, n = 1)]]
                     )
      )
  }
  } else{
    NGLVieweR_proxy(structure) %>%
       removeSelection(name = "deepth")
  }

  # NGLVieweR_proxy(structure) %>%
  #   updateColor(tail(cav_rep_list,n=1),color= "resname")
}
