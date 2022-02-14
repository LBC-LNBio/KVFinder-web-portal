#' Create radio buttons of the run mode in main Run KVFinder page 
#' 
#' @import shiny
#' 

create_radio_mode <- function(){
  mode_rad <- radioButtons("run_mode", "Detect cavities in:",
               c("Whole structure (default)" = "mode_def",
                 "Whole structure (customized)" = "mode_cust",
                 "Around target molecule" = "lig_mode",
                 "Around target residues" = "box_mode"))  
  return(mode_rad)
} 
