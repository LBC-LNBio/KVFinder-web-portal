#' Function that submits the KVFinder job to the server 
#' 
#' @param input shiny input
#' @param output shiny output
#' @param pdb_name_click_load variable of the number of clicks on load button
#' @param url_address url address to conexion 
#' @param session
#' 
#' @import shiny
#' @import rjson
#' @import jsonlite
#' @import rlang
#' @import httr
#' @import shinyWidgets
#' 
#' @export
#' 

submit_job <- function(input, output, pdb_name_click_load, url_address, session){
  #-------------------------------------------------------------------
  #Get KVFinder parameters from the user interface 
  probein_input <- input[[paste(input$run_mode, "Pin_input", sep = "_")]]
  probeout_input <- input[[paste(input$run_mode, "Pout_input", sep = "_")]]
  removal_dist_input <- input[[paste(input$run_mode, "RD_input", sep = "_")]]
  vol_cutoff_input <- input[[paste(input$run_mode, "VC_input", sep = "_")]]
  lig_cutoff_input <- input$lig_cutoff 
  padding_input <- input$padding_value
  #-------------------------------------------------------------------
  
  
  #check if probe in is smaller than probe out
  if(probein_input > probeout_input){
    shinyWidgets::sendSweetAlert(session = session,title = "Oops!", text = "Probe In must be smaller than Probe Out.", type = "error")
    # check if user uploaded a PDB or fetched a PDB ID before to submit
  } else if(is.null(input$input_pdb) & input$pdb_id == ""){ 
    shinyWidgets::sendSweetAlert(session = session,title = "Oops!", text = "Please load from PDB or upload a PDB file before to submit.", type = "error")
    #Check if the user that is using the fetch mode clicked on the Load button before to submit
  } else if(pdb_name_click_load != "init" & pdb_name_click_load != input$pdb_id){ #
    shinyWidgets::sendSweetAlert(session = session,title = "Oops!", text = "Please after input PDB ID in Choose input section, be sure you loaded the PDB by clicking on the Load button.", type = "error")
    # Just another check if user uploaded a PDB or fetched a PDB ID before to submit
  } else if(length(input$pdb_id) > 0 & input$send_pdb_id == 0){ 
    shinyWidgets::sendSweetAlert(session = session,title = "Oops!", text = "Please load from PDB or upload a PDB file before to submit.", type = "error")
  } else {
    #if pass through the above checks...
    #get pdb_processed from upload mode
    if(input$input_type == 'pdb_from_file'){
      pdb_processed <- pdb_process(input = input, output = output, get_nonstand = get_nonstand, mode = "upload", session = session)
      #get pdb_processed from fetch mode
    } else{
      pdb_processed <- pdb_process(input = input, output = output, get_nonstand = get_nonstand, mode = "fetch", session = session)
    }
    #check if the list of residues in "target residues" field is appropriated. The function pdb_process (in mod_server_pdbProcess.R) returns "wrong_target_res" if the input is not in the required format 
    if(pdb_processed != "wrong_target_res"){ 
      #get the path of the pdb processed
      if(is.null(pdb_processed$pdb_processed)) {
        pdb_path <- input$input_pdb$datapath
      } else{
        pdb_path <- pdb_processed$pdb_processed
      }
      #check if user inserted a valid PDB before do submit
      if(length(pdb_path) == 0){
        shinyWidgets::sendSweetAlert(session = session,title = "Oops!", text ="Please insert a valid PDB before to submit.", type = "error")
      } else {
        #Create a KVFinder input file based on the specific target mode to be submitted to the server using submit_prepare function
        #Whole protein (default parameters)
        if(input$run_mode == 'mode_def'){
          input_list <- submit_prepare(pdb_path = pdb_path,ligand_path = NULL, whole_protein_mode = TRUE,  ligand_mode = FALSE, box_mode = FALSE, box_residues = NULL, probe_in = 1.4, probe_out =4, volume_cutoff = 5, removal_distance = 2.4, padding = NULL, lig_cutoff = NULL)
        #Around target molecule or ligand - ligand mode
        } else if(input$run_mode == 'lig_mode'){ 
          input_list <- submit_prepare(pdb_path = pdb_path, ligand_path = pdb_processed$pdb_lig_processed, whole_protein_mode = TRUE, ligand_mode = TRUE,box_mode = FALSE,box_residues = NULL, probe_in = probein_input, probe_out = probeout_input, volume_cutoff = vol_cutoff_input, removal_distance = removal_dist_input, padding = NULL, lig_cutoff = lig_cutoff_input)
        #Around target residues - box mode
        } else if(input$run_mode == 'box_mode'){ 
          input_list <- submit_prepare(pdb_path = pdb_path, ligand_path = NULL, whole_protein_mode = FALSE, ligand_mode = FALSE,box_mode = TRUE,box_residues = input$box_residues, probe_in = probein_input, probe_out = probeout_input, volume_cutoff = vol_cutoff_input, removal_distance = removal_dist_input, padding = padding_input, lig_cutoff = NULL)
        # Whole protein with customized parameters
        } else { 
          input_list <- submit_prepare(pdb_path = pdb_path, ligand_path = NULL, whole_protein_mode = TRUE, ligand_mode = FALSE,box_mode = FALSE, box_residues = NULL, probe_in = probein_input, probe_out = probeout_input, volume_cutoff = vol_cutoff_input, removal_distance = removal_dist_input, padding = NULL, lig_cutoff = NULL)
        }
        
        #submit to parKVFinder server
        #post_output <- POST(url = "http://10.0.0.123:8081/create",body = input_list, encode = "json")
        post_output <- POST(url = paste(url_address,"create",sep=""),body = input_list, encode = "json") #using localhost
        #check status for submission error 
        if(post_output$status_code == 200){ #job is running successfully
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
          #return the job id 
          return(get_run_id)
        } else{ # if the submission status is other than 200
          shinyWidgets::sendSweetAlert(session = session,title = "Oops!", text ="An error occurred when submitting your job. Perhaps the input file is larger than what our server allows or the input parameters are outside the allowed limits. Please read our Help page and if the problem persist please contact us.", type = "error")
        }
      }
    }
  }
}