#' Select cavities to show
#'
#' @param input shiny input
#' @param output shiny output
#' @param result_pdb_list a list returned by check function
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page).
#'
#' @import shiny
#' @import NGLVieweR
#'
#' @export
#'


select_cav <- function(input, output, result_pdb_list, is_pg2) {
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
    NGLVieweR_proxy(structure) %>%
      updateSelection("point", sele = paste(result_pdb_list$result_cav_names, collapse = " or "))
  } else { # show one cavity to show and zoom it
    print(input$input_cavity_deep)
    if(isTRUE(input$input_cavity_deep) | isTRUE(input$input_cavity_deep_pg2)){
      NGLVieweR_proxy(structure) %>%
        updateSelection("point", sele = "not all") %>%
        updateSelection("deepth", sele = input[[select_cavity]]) %>%
        updateZoomMove(input[[select_cavity]], input[[select_cavity]], 2000, -20)
    } else if(isTRUE(input$input_cavity_hyd) | isTRUE(input$input_cavity_hyd_pg2)){
      NGLVieweR_proxy(structure) %>%
        updateSelection("point", sele = "not all") %>%
        updateSelection("hyd", sele = input[[select_cavity]]) %>%
        updateZoomMove(input[[select_cavity]], input[[select_cavity]], 2000, -20)
    } else{
      NGLVieweR_proxy(structure) %>%
        updateSelection("point", sele = input[[select_cavity]]) %>%
        updateZoomMove(input[[select_cavity]], input[[select_cavity]], 2000, -20)
    }

  }
}
