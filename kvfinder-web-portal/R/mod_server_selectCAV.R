#' Select cavities to show
#'
#' @param input shiny input
#' @param output shiny output
#' @param result_pdb_list a list returned by check function
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page).
#' @param cav_rep_list
#' @import shiny
#' @import NGLVieweR
#'
#' @export
#'


select_cav <- function(input, output, result_pdb_list, is_pg2, cav_rep_list) {
  if (is_pg2 == TRUE) {
    select_cavity <- "select_cavity_pg2"
    structure <- "structure_pg2"
    interface_res <- "interface_res_pg2"
  } else {
    select_cavity <- "select_cavity"
    structure <- "structure"
    interface_res <- "interface_res"
  }
  # if click to select cavity...
  if (input[[select_cavity]] == "All") { # show all cavities
   if(!is.null(cav_rep_list)){
     if(tail(cav_rep_list, n = 1) == 'point'){
       NGLVieweR_proxy(structure) %>%
         updateSelection("point", sele = paste(result_pdb_list$result_cav_names, collapse = " or "))
     }
     if(tail(cav_rep_list, n = 1) == 'surface'){
       NGLVieweR_proxy(structure) %>%
         updateSelection("surface", sele = paste(result_pdb_list$result_cav_names, collapse = " or "))
     } 
   }
     
  } else { # show one cavity to show and zoom it
    print(input$input_cavity_deep)
    print(paste(input[[select_cavity]]," and (not ",paste(result_pdb_list$result_cav_names[!result_pdb_list$result_cav_names == input[[select_cavity]]], collapse = " or "),')', sep=""))
    if(isTRUE(input$input_cavity_deep) | isTRUE(input$input_cavity_deep_pg2)){
      NGLVieweR_proxy(structure) %>%
        updateSelection("point", sele = paste(input[[select_cavity]]," and (not ",paste(result_pdb_list$result_cav_names[!result_pdb_list$result_cav_names == input[[select_cavity]]], collapse = " or "),')', sep="")) %>%
        updateSelection("deepth", sele = input[[select_cavity]]) %>%
        updateZoomMove(input[[select_cavity]], input[[select_cavity]], 2000, -20)
    } else if(isTRUE(input$input_cavity_hyd) | isTRUE(input$input_cavity_hyd_pg2)){
      NGLVieweR_proxy(structure) %>%
        updateSelection("point", sele = paste(input[[select_cavity]]," and (not ",paste(result_pdb_list$result_cav_names[!result_pdb_list$result_cav_names == input[[select_cavity]]], collapse = " or "),')', sep="")) %>%
        updateSelection("hyd", sele = input[[select_cavity]]) %>%
        updateZoomMove(input[[select_cavity]], input[[select_cavity]], 2000, -20)
    } else{
      if(tail(cav_rep_list, n = 1) == 'point'){
        NGLVieweR_proxy(structure) %>%
          updateSelection("point", sele = input[[select_cavity]]) %>%
          updateZoomMove(input[[select_cavity]], input[[select_cavity]], 2000, -20)
      }
      if(tail(cav_rep_list, n = 1) == 'surface'){
        NGLVieweR_proxy(structure) %>%
          updateSelection("surface", sele = input[[select_cavity]]) %>%
          updateZoomMove(input[[select_cavity]], input[[select_cavity]], 2000, -20)
      }

    }

  }
}
