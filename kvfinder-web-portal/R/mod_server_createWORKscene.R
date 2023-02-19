#' Create work scene to allow changes in NGL viewer
#'
#' @param input shiny input
#' @param output shiny output
#' @param protein_rep_list list of previous biomolecular structure representations
#' @param protein_col_list list of previous biomolecular structure colors
#' @param protein_col_scheme_list list of protein color schemes
#' @param result_pdb_list a list returned by check function
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page).
#' @param scheme_color_list a named list of possible protein color schemes
#' @param prot_or_cav 'prot' or 'cav'
#' @param cav_rep_list
#' @import shiny
#' @import NGLVieweR
#'
#' @export
#'

create_work_scene <- function(input, output, protein_rep_list, protein_col_list, protein_col_scheme_list, result_pdb_list, is_pg2, scheme_color_list, prot_or_cav, cav_rep_list) {
  # when it is the secondary page (get latest results - pg2)
  if (is_pg2 == TRUE) {
    input_protein_rep <- "input_protein_rep_pg2"
    structure <- "structure_pg2"
    # in the main page
  } else {
    input_protein_rep <- "input_protein_rep"
    structure <- "structure"
  }
  # The work scene is always linked to the input_protein_rep input -> It is the start point
  # If protein_rep_list contains only 1 representations that means that it is still an initial scene, so we need to modify the visibility of the structure from initial scene to invisible
  if (length(protein_rep_list) == 1) {
    NGLVieweR_proxy(structure) %>%
      updateVisibility("protein_init_cartoon", value = FALSE)
  }
  if (prot_or_cav == 'prot'){
    print("inside protein mode")
    # After the initial structure is invisible, we can add a new representation to the current scene
    NGLVieweR_proxy(structure) %>%
      addSelection(tail(protein_rep_list, n = 1),
                   param =
                     list(
                       name = "sel2", # now the created selection is named "sel2"
                       sele = "protein or nucleic",
                       colorScheme = scheme_color_list[[tail(protein_col_scheme_list, n = 1)]]
                     )
      )
    # In the case of protein representation selector has more than one representation, i.e. was used previously and is not a initial scene
    # We dont need to change the visibility, just remove the latest representation and include a new selection
    if (length(protein_rep_list) > 1) {
      NGLVieweR_proxy(structure) %>%
        removeSelection(name = "sel2")
      # Include the new representation
      NGLVieweR_proxy(structure) %>%
        addSelection(tail(protein_rep_list, n = 1),
                     param =
                       list(
                         name = "sel2",
                         sele = paste("NOT (", paste(result_pdb_list$result_cav_names, collapse = " or "), ")", sep = ""),
                         colorScheme = scheme_color_list[[tail(protein_col_scheme_list, n = 1)]]
                       )
        )
    }
  } 
  
  if(prot_or_cav == 'cav' & length(cav_rep_list) >1) { #cav mode
    print("inside cavity mode")
    NGLVieweR_proxy(structure) %>%
      removeSelection(name = tail(cav_rep_list, n = 2)[1])
    # After the initial structure is invisible, we can add a new representation to the current scene
    if(tail(cav_rep_list, n = 1) == "surface"){
      op = 0.5
    } else {
      op = 1
    }
    NGLVieweR_proxy(structure) %>%
      addSelection(tail(cav_rep_list, n = 1),
                   param =
                     list(
                       name = tail(cav_rep_list, n = 1), # now the created selection is named "sel3"
                       sele = paste(result_pdb_list$result_cav_names, collapse = " or "),
                       surfaceType = 'vws',
                       probeRadius = 0.3,
                       opacity = op
                       #colorScheme = scheme_color_list[[tail(protein_col_scheme_list, n = 1)]]
                     )
      )
    # In the case of protein representation selector has more than one representation, i.e. was used previously and is not a initial scene
    # We dont need to change the visibility, just remove the latest representation and include a new selection
    # if (length(cav_rep_list) > 1) {
    #   NGLVieweR_proxy(structure) %>%
    #     removeSelection(name = tail(cav_rep_list, n = 1))
    #   # Include the new representation
    #   NGLVieweR_proxy(structure) %>%
    #     addSelection(tail(cav_rep_list, n = 1),
    #                  param =
    #                    list(
    #                      name = "sel3",
    #                      sele = paste(result_pdb_list$result_cav_names, collapse = " or ")
    #                      #colorScheme = scheme_color_list[[tail(protein_col_scheme_list, n = 1)]]
    #                    )
    #     )
    # }
  }
  
}
