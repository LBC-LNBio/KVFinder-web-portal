#' Function that process the uploaded or fetched PDB. This function is called in mod_server_submitJob module. 
#' 
#' @param input shiny input
#' @param output shiny output
#' @param get_nonstand vector of non-standard residues from the input PDB 
#' @param mode select between "upload" or "fetch" modes 
#' @param session
#' 
#' @import shiny
#' @import shinyWidgets
#' 
#' @export
#' 
pdb_process <- function(input, output, get_nonstand, mode, session){
  #if the PDB was uploaded
  if(mode == "upload"){
    #path of the pdb input
    pdb_input = input$input_pdb$datapath
    #list of non-standard residues that will be included in the analysis
    include_list = input$select_nonstand1
  } else{ #if the PDB was fetched by the ID
    #get the pdb ID
    pdb_input = input$pdb_id
    #list of non-standard residues that will be included in the analysis
    include_list = input$select_nonstand2
  }
  #create a processed PDB for each run mode: default, customized, ligand or box mode
  if(input$run_mode == "mode_def"){
    pdb_processed <- deal_sele_nonstand(pdb_input = pdb_input,nonstand_list = get_nonstand, include_list = include_list)
    pdb_processed <- list(pdb_processed = pdb_processed)
  } else if(input$run_mode == "mode_cust"){
    pdb_processed <- deal_sele_nonstand(pdb_input = pdb_input,nonstand_list = get_nonstand, include_list = include_list)
    pdb_processed <- list(pdb_processed = pdb_processed)
  } else if(input$run_mode == "box_mode"){
    #in the case of running the box mode, we have to check if the target residues are correctly in the PDB input
    check_residues = check_residues_name(pdb_input = pdb_input, target_residues = input$box_residues)
    if(check_residues == FALSE){
      shinyWidgets::sendSweetAlert(session = session,title = "Oops!", text = "Please insert a valid list of residues for box mode run.", type = "error")
      pdb_processed <- "wrong_target_res"
    } else{
      pdb_processed <- deal_sele_nonstand(pdb_input = pdb_input,nonstand_list = get_nonstand, include_list = include_list)
      pdb_processed <- list(pdb_processed = pdb_processed)
    }
  } else { #enter in the ligand mode
    #extract ligand pdb 
    pdb_ligand_processed <- get_ligand_pdb(pdb_input = pdb_input, ligand_name = input$lig_name)
    #update nonstandard residues list to exclude the ligand 
    get_nonstand_noLig <- setdiff(get_nonstand,input$lig_name) #get all non-standand but the ligand
    #by default remove all non standards residues and the ligand 
    pdb_processed <- deal_sele_nonstand(pdb_input = pdb_input,nonstand_list = c(get_nonstand,input$lig_name), include_list = include_list)
    pdb_processed <- list(pdb_processed = pdb_processed, pdb_lig_processed = pdb_ligand_processed)
  }
  return(pdb_processed)  
}