#' Create radio buttons of the run mode in main Run KVFinder page 
#' 
#' @import shiny
#' 
#' @export

kv_params <- function(id, input_type){
  #ns <- NS(id)
  if(input_type == "probe_in"){
    num_input <- numericInput(
                 inputId = paste(id,"Pin_input",sep="_"),
                 label = "Probe in (Å):",
                 value = 1.4,
                 min = 0,
                 max = 5,
                 step = 0.1,
                 width = 60)
    return(num_input)
  } else if(input_type == "probe_out"){
    num_input <-  numericInput(
                  inputId = paste(id,"Pout_input",sep="_"),
                  label = "Probe out (Å):",
                  value = 4,
                  min = 0,
                  max = 50,
                  step = 1,
                  width = 60)
    return(num_input)
  } else if(input_type == "removal_dist"){
    num_input <-  numericInput(
                  inputId = paste(id,"RD_input",sep="_"),
                  label = "Removal distance (Å):",
                  value = 2.4,
                  min = 0,
                  max = 10,
                  step = 0.1,
                  width = 80)
    return(num_input)
  } else {
    num_input <- numericInput(
                  inputId = paste(id,"VC_input",sep="_"),
                  label = "Volume cutoff (Å):",
                  value = 5,
                  min = 0,
                  max = 50000,
                  step = 1,
                  width = 60)
    return(num_input)
  }

}
