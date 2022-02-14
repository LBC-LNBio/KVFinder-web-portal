#' Steps to process uploaded PDB in ligand mode 
#' 
#' @param input shiny input
#' @param output shiny output
#' 
#' @import shiny
#' @import shinyalert
#' 
#' @export



process_upload_ligmode <- function(input, output){
  
  #check if ligand name text box is filled and the PDB input contains the ligand 
  check_lig = check_lig_name(pdb_input = input$input_pdb$datapath, target_ligand = input$lig_name)
  if(check_lig == FALSE){
    shinyalert("Oops!", "Please insert a 3-letter valid ligand name.", type = "error")
  } else{
    #if so, get the ligand PDB 
    pdb_ligand_processed <<- get_ligand_pdb(pdb_input = input$input_pdb$datapath, ligand_name = input$lig_name)
  }
  #get nonstandard residues from the input PDB, excepted the target ligand 
  get_nonstand <- report_nonstand(pdb_input = input$input_pdb$datapath)
  get_nonstand <- setdiff(get_nonstand,input$lig_name) #get all non stand but the ligand

  
  #if there is any nonstand residue in PDB...
  if(length(get_nonstand) > 0){
    
    #by default remove all non standards residues and the ligand 
    pdb_processed <<- deal_sele_nonstand(pdb_input = input$input_pdb$datapath,nonstand_list = c(get_nonstand,input$lig_name), include_list = NULL)
    
    #create a check box to allow users to include some nonstandard residues
    output$checkbox_nostand1 <- renderUI({
      checkboxGroupInput(inputId =  "select_nonstand1", label =  "Non-standard protein/nucleic residues found in the input structure (not including the target molecule):", choices =  get_nonstand, selected = TRUE,width = 800)
    })
    
    output$note_text1 <- renderUI({
      tags$h6(strong("Note:"),"By default the KVFinder server remove all non-standard residues from the input file. 
                   If you intend to consider the residues below in cavity detection, please select them and click include.
                  Otherwise, keep the check box unselected.",style= "text-align:justify")
    })
    
    observeEvent(input$select_nonstand1,{
      output$ask_preprocess_include1 <- renderUI({ 
        tags$b("Do you want to include them in KVFinder run?")
      })
      
      output$preprocess_include1 <- renderUI({
        actionButton(inputId = "go_include1", label = "Include")
      })
    })
    
    #If users click in include button, the selected residues will be considered in KVFinder run 
    observeEvent(input$go_include1,{
      pdb_processed <<- deal_sele_nonstand(pdb_input = input$input_pdb$datapath,nonstand_list = c(get_nonstand,input$lig_name), include_list = input$select_nonstand1)
      shinyalert("Residues successfully included.", type = "success", timer = 2000)
    })
    
  } else{
    #if there is no nonstarndad residue in PDB input, just remove the ligand 
    pdb_processed <<- deal_sele_nonstand(pdb_input = input$input_pdb$datapath,nonstand_list = input$lig_name, include_list = NULL) #remove ligand
    #Do not show any widgets related to nonstandard residues inclusion
    output$checkbox_nostand1 <- NULL
    output$note_text1 <- NULL
    output$ask_preprocess_include1 <- NULL
    output$preprocess_include1 <- NULL
  }
  
}




