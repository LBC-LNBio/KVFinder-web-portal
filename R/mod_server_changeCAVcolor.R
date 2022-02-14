#' Change color of cavities
#' 
#' @param input shiny input
#' @param output shiny output
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page). 
#' 
#' @import shiny
#' @import NGLVieweR
#'
#' @export
#' 

change_cav_color <- function(input, output, is_pg2){
  if(is_pg2 == TRUE){
    input_cavity_color <- "input_cavity_color_pg2"
    structure <- "structure_pg2"
  } else{
    input_cavity_color <- "input_cavity_color"
    structure <- "structure"
  }
    NGLVieweR_proxy(structure) %>%
      updateColor("point", input[[input_cavity_color]])
}