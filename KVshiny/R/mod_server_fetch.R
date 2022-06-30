#' Steps to process  PDB from fetch in default, customized or box mode
#' 
#' @param input shiny input
#' @param output shiny output
#' 
#' @import shiny
#' @import shinyalert
#' 
#' @export
#' 

process_fetch <- function(input, output){
  
  # #check the target resides if KVFinder is running in box mode
  # if(input$run_mode == "box_mode"){ #only to check correct residues names
  #   check_residues = check_residues_name(pdb_input = input$pdb_id, target_residues = input$box_residues)
  #   if(check_residues == FALSE){
  #     shinyalert("Oops!", "Please insert a valid list of residues for box mode run.", type = "error")
  #   } else{
  #     print("check residues OK")
  #   }
  # }

  #get nonstandard residues from the input PDB
  get_nonstand <<- report_nonstand(pdb_input = input$pdb_id)

  
  #if there is any nonstand residue in PDB...
  if(length(get_nonstand) > 0){
    
    #always start by updating the radio button -> this was done because we need to update to remove the ligand mode if there's no ligand
    #so we need to always update to show all buttons
    updateRadioButtons(inputId = "run_mode",
                       label = "Detect cavities in:",
                       choices = c("Whole structure (default)" = "mode_def",
                                   "Whole structure (customized)" = "mode_cust",
                                   "Around target molecule" = "lig_mode",
                                   "Around target residues" = "box_mode"))
    
    #checkpoint to create the uiOuput of show_lig_name of ligmode
    updateSelectInput(inputId = "lig_name",
                      label = "Ligand or molecule name:",
                      choices = get_nonstand,
                      selected = NULL
    )
    
    #print(get_nonstand)
    #by default remove all non standards residues and the ligand 
    #pdb_processed <<- deal_sele_nonstand(pdb_input = input$pdb_id,nonstand_list = get_nonstand, include_list = NULL)
    

    
    #create a check box to allow users to include some nonstandard residues
    output$checkbox_nostand2 <- renderUI({
      checkboxGroupInput(inputId =  "select_nonstand2", label =  "Non-standard residues found (select to include them in the analysis):", choices =  get_nonstand, selected = TRUE,width = 800)
    })
    
    output$note_text2 <- renderUI({
      tags$h6(strong("Note:"),"By default, the KVFinder server removes all non-standard residues from the input file and that is usually the preferred choice. 
                   For specific cases, if you intend to consider the residues below in cavity detection, please select the box to include them.
                     Otherwise, keep the check box unselected.",style= "text-align:justify")
    })
    # observeEvent(input$select_nonstand2,{
    #   output$ask_preprocess_include2 <- renderUI({ 
    #     tags$b("Do you want to include them in KVFinder run?")
    #   })
    #   
    #   output$preprocess_include2 <- renderUI({
    #     actionButton(inputId = "go_include2", label = "Include")
    #   })
    # })
    # 
    # 
    # #If users click in include button, the selected residues will be considered in KVFinder run 
    # observeEvent(input$go_include2,{
    #   pdb_processed <<- deal_sele_nonstand(pdb_input = input$pdb_id,nonstand_list = get_nonstand, include_list = input$select_nonstand2)
    #   shinyalert("Residues successfully included.", type = "success", timer = 2000)
    # })
    
  } else{
    #Do not show any widgets related to nonstandard residues inclusion
    output$checkbox_nostand2 <- NULL
    output$note_text2 <- NULL
    output$ask_preprocess_include2 <- NULL
    output$preprocess_include2 <- NULL
    
    #below code is to avoid to show ligand from the previous round if no non-stand is found
    updateRadioButtons(inputId = "run_mode",
                       label = "Detect cavities in:",
                       choices = c("Whole structure (default)" = "mode_def",
                                   "Whole structure (customized)" = "mode_cust",
                                   "Around target residues" = "box_mode"))
  }
  
  
}