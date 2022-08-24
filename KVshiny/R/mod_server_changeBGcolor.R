#' Function that change background color in NGL viewer
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

change_bg_color <- function(input, output, is_pg2){
  if(is_pg2 == TRUE){
    input_bg_color <- "input_bg_color_pg2"
    structure <- "structure_pg2"
  } else{
    input_bg_color <- "input_bg_color"
    structure <- "structure"
  }
  NGLVieweR_proxy(structure) %>%
    updateStage(
      param = list("backgroundColor" = input[[input_bg_color]]))
}