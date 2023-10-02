#' Function that changes color of the cavities in NGL viewer
#'
#' @param input shiny input
#' @param output shiny output
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page).
#' @param cav_rep_list
#' 
#' @import shiny
#' @import NGLVieweR
#'
#' @export
#'

change_cav_color <- function(input, output, is_pg2, cav_rep_list) {
  if (is_pg2 == TRUE) {
    input_cavity_color <- "input_cavity_color_pg2"
    structure <- "structure_pg2"
  } else {
    input_cavity_color <- "input_cavity_color"
    structure <- "structure"
  }

  if(!is.null(cav_rep_list)){ #this is to make sure that this will work on the second time loaded page
    NGLVieweR_proxy(structure) %>%
      updateColor(tail(cav_rep_list,n=1), input[[input_cavity_color]])
  } else {
    NGLVieweR_proxy(structure) %>%
      updateColor("point", input[[input_cavity_color]])
  }
  

}
