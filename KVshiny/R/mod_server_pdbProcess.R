#' Steps to process uploaded or fetched PDB 
#' 
#' @param input shiny input
#' @param output shiny output
#' @param get_nonstand get_nonstand
#' @param mode upload or fetch 
#' 
#' @import shiny
#' @import shinyalert
#' 
#' @export
#' 
pdb_process <- function(input, output, get_nonstand, mode){
  if(mode == "upload"){
    pdb_input = input$input_pdb$datapath
    include_list = input$select_nonstand1
  } else{
    pdb_input = input$pdb_id
    include_list = input$select_nonstand2
  }
  
  if(input$run_mode == "mode_def"){
    pdb_processed <- deal_sele_nonstand(pdb_input = pdb_input,nonstand_list = get_nonstand, include_list = include_list)
    #print(pdb_processed)
    pdb_processed <- list(pdb_processed = pdb_processed)
  } else if(input$run_mode == "mode_cust"){
    pdb_processed <- deal_sele_nonstand(pdb_input = pdb_input,nonstand_list = get_nonstand, include_list = include_list)
    pdb_processed <- list(pdb_processed = pdb_processed)
  } else if(input$run_mode == "box_mode"){
    #check the target resides if KVFinder is running in box mode
    check_residues = check_residues_name(pdb_input = pdb_input, target_residues = input$box_residues)
    if(check_residues == FALSE){
      shinyalert("Oops!", "Please insert a valid list of residues for box mode run.", type = "error")
      pdb_processed <- "wrong_target_res"
    } else{
      pdb_processed <- deal_sele_nonstand(pdb_input = pdb_input,nonstand_list = get_nonstand, include_list = include_list)
      pdb_processed <- list(pdb_processed = pdb_processed)
    }
  } else { #lig mode
    #get lig pdb 
    pdb_ligand_processed <- get_ligand_pdb(pdb_input = pdb_input, ligand_name = input$lig_name)
    #update nonstand to does not include lig 
    get_nonstand_noLig <- setdiff(get_nonstand,input$lig_name) #get all non stand but the ligand
    #by default remove all non standards residues and the ligand 
    pdb_processed <- deal_sele_nonstand(pdb_input = pdb_input,nonstand_list = c(get_nonstand,input$lig_name), include_list = include_list)
    #->>>>>>>>>>>> #pdb_processed <<- deal_sele_nonstand(pdb_input = input$input_pdb$datapath,nonstand_list = input$lig_name, include_list = NULL) #remove ligand ????????????????
    pdb_processed <- list(pdb_processed = pdb_processed, pdb_lig_processed = pdb_ligand_processed)
  }
  

    return(pdb_processed)  

  
  
  
}