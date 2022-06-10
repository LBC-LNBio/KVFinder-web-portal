#' Submit job 
#' 
#' @param input shiny input
#' @param output shiny output
#' @param pdb_name_click_load pdb_name_click_load
#' @import shiny
#' @import rjson
#' @import jsonlite
#' @import rlang
#' @import httr
#' 
#' @export
#' 

submit_job <- function(input, output, pdb_name_click_load){
  
  #-------------------------------------------------------------------
  #Get KV parameters from ui 
  probein_input <- input[[paste(input$run_mode, "Pin_input", sep = "_")]]
  probeout_input <- input[[paste(input$run_mode, "Pout_input", sep = "_")]]
  removal_dist_input <- input[[paste(input$run_mode, "RD_input", sep = "_")]]
  vol_cutoff_input <- input[[paste(input$run_mode, "VC_input", sep = "_")]]
  lig_cutoff_input <- input$lig_cutoff 
  padding_input <- input$padding_value
  #-------------------------------------------------------------------

  
  #check probe in is smaller than probe out
  if(probein_input > probeout_input){
    shinyalert("Oops!", "Probe In must be smaller than Probe Out.", type = "error")
  } else if(is.null(input$input_pdb) & input$pdb_id == ""){
    shinyalert("Oops!", "Please load from PDB or upload a PDB file before to submit.", type = "error")
  } else if(pdb_name_click_load != "init" & pdb_name_click_load != input$pdb_id){
    shinyalert("Oops!", "Please after input PDB ID in Choose input section, be sure you loaded the PDB by clicking in Load button.", type = "error")
  } else if(length(input$pdb_id) > 0 & input$send_pdb_id == 0){ 
    shinyalert("Oops!", "Please load from PDB or upload a PDB file before to submit.", type = "error")
  #} else if(input$run_mode == 'lig_mode' & (input$lig_name != input$select_nonstand1 | input$lig_name != input$select_nonstand2)){ #to check 
    
  } else {
    #print("hereSub")
    #get pdb_processed 
    if(input$input_type == 'pdb_from_file'){
      
      pdb_processed <- pdb_process(input = input, output = output, get_nonstand = get_nonstand, mode = "upload")

    } else{
      pdb_processed <- pdb_process(input = input, output = output, get_nonstand = get_nonstand, mode = "fetch")
    }
    
    if(pdb_processed != "wrong_target_res"){ #check if the list of residues in "target residues" field is appropriated. The function pdb_process (in mod_server_pdbProcess.R) returns "wrong_target_res" if the input is not in the required format 
      
    #get the PDB processed 
    if(is.null(pdb_processed$pdb_processed)) {
      pdb_path <- input$input_pdb$datapath
    } else{
      pdb_path <- pdb_processed$pdb_processed
    }
    
    #print(pdb_path)
    #check if user inserted a valid PDB before do submit
    if(length(pdb_path) == 0){
      shinyalert("Oops!", "Please insert a valid PDB before to submit.", type = "error")
    #} #else if(length(pdb_path) != 0 & length(run_mode_list) > 0){
      #shinyalert("Oops!", "If you changed the run mode, please reload your PDB.", type = "error")
    #} #else if(length(pdb_path) != 0 & length(run_mode_list) == 0 & length(lig_name_list) > 0){
      #shinyalert("Oops!", "If you changed the ligand or molecule name, please reload your PDB.", type = "error")
    } else {
      
      # Create modal dialog
      showModal(modalDialog("Submitting...", footer=NULL,fade = FALSE))
      
      #Create a KVFinder input file to be submitted to the server 
      #Whole protein (default parameters)
      if(input$run_mode == 'mode_def'){
        input_list <- submit_prepare(pdb_path = pdb_path,ligand_path = NULL, whole_protein_mode = TRUE,  ligand_mode = FALSE, box_mode = FALSE, box_residues = NULL, probe_in = 1.4, probe_out =4, volume_cutoff = 5, removal_distance = 2.4, padding = NULL, lig_cutoff = NULL)
      } else if(input$run_mode == 'lig_mode'){ #Around target molecule or ligand
        input_list <- submit_prepare(pdb_path = pdb_path, ligand_path = pdb_processed$pdb_lig_processed, whole_protein_mode = TRUE, ligand_mode = TRUE,box_mode = FALSE,box_residues = NULL, probe_in = probein_input, probe_out = probeout_input, volume_cutoff = vol_cutoff_input, removal_distance = removal_dist_input, padding = NULL, lig_cutoff = lig_cutoff_input)
      } else if(input$run_mode == 'box_mode'){ #Around target residues
        input_list <- submit_prepare(pdb_path = pdb_path, ligand_path = NULL, whole_protein_mode = FALSE, ligand_mode = FALSE,box_mode = TRUE,box_residues = input$box_residues, probe_in = probein_input, probe_out = probeout_input, volume_cutoff = vol_cutoff_input, removal_distance = removal_dist_input, padding = padding_input, lig_cutoff = NULL)
      } else { # Whole protein (customized parameters)
        input_list <- submit_prepare(pdb_path = pdb_path, ligand_path = NULL, whole_protein_mode = TRUE, ligand_mode = FALSE,box_mode = FALSE, box_residues = NULL, probe_in = probein_input, probe_out = probeout_input, volume_cutoff = vol_cutoff_input, removal_distance = removal_dist_input, padding = NULL, lig_cutoff = NULL)
      }
      

      #submit to parKVFinder server
      #post_output <- POST(url = "http://10.0.0.123:8081/create",body = input_list, encode = "json")
      post_output <- POST(url = "http://localhost:8081/create",body = input_list, encode = "json") #using localhost

      #get ID of the submitted job
      get_run_id <<- content(post_output)$id

      #Show submission message
      output$run_id <- renderText({paste(p("Your job was successfully submitted to KVFinder server."), p("Your run ID is: "), p(tags$b(get_run_id)), 
                                         p("The results of this run will be available for 1 day"),
                                         p("Save this ID to check results later"))})
      #Create check result button
      output$check_results_submit <- renderUI({
        actionButton(inputId = "go_to_check_results",label = "Check results", size = "lg", icon = icon("poll-h"))
      })
      
      #Message indicating automatically status updating 
      # output$status_auto <- renderText({paste(p("Your job was successfully submitted to KVFinder server."), p("Your run ID is: "), p(tags$b(get_run_id)), 
      #                                    p("The results of this run will be available for 1 day"),
      #                                    p("Save this ID to check results later"))})
      
      # Stop modal dialog
      removeModal()
      
      return(get_run_id)
    }
    
  }
  }
  
}