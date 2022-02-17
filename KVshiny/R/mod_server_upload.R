#' Steps to process  uploaded PDB in default, customized or box mode
#' 
#' @param input shiny input
#' @param output shiny output
#' 
#' @import shiny
#' @import shinyalert
#' 
#' @export
#' 

process_upload <- function(input, output){
 
  #check the target resides if KVFinder is running in box mode
  # if(input$run_mode == "box_mode"){ #only to check correct residues names
  #   check_residues = check_residues_name(pdb_input = input$input_pdb$datapath, target_residues = input$box_residues)
  #   if(check_residues == FALSE){
  #     shinyalert("Oops!", "Please insert a valid list of residues for box mode run.", type = "error")
  #   } else{
  #     print("check residues OK")
  #   }
  # }
  #get nonstandard residues from the input PDB
  get_nonstand <<- report_nonstand(pdb_input = input$input_pdb$datapath)
  print(get_nonstand)
  
  #if there is any nonstand residue in PDB...
  if(length(get_nonstand) > 0){
    
    #checkpoint to create the uiOuput of show_lig_name of ligmode
    #output$show_lig_name <- renderUI({
      updateSelectInput(inputId = "lig_name",
                  label = "Ligand or molecule name:",
                  choices = get_nonstand,
                  selected = NULL
      )
    #})

    
    #by default remove all non standards residues and the ligand 
    #pdb_processed <<- deal_sele_nonstand(pdb_input = input$input_pdb$datapath,nonstand_list = get_nonstand, include_list = NULL)
    
    #create a check box to allow users to include some nonstandard residues
    output$checkbox_nostand1 <- renderUI({
      checkboxGroupInput(inputId =  "select_nonstand1", label =  "Non-standard residues found:", choices =  get_nonstand, selected = TRUE,width = 800)
    })
    
    output$note_text1 <- renderUI({
      tags$h6(strong("Note:"),"By default the KVFinder server remove all non-standard residues from the input file. 
                   If you intend to consider the residues below in cavity detection, please select them and click include.
                     Otherwise, keep the check box unselected.",style= "text-align:justify")
    })
    # observeEvent(input$select_nonstand1,{
    #   output$ask_preprocess_include1 <- renderUI({ 
    #     tags$b("Do you want to include them in KVFinder run?")
    #   })
    #   
    #   
    #   output$preprocess_include1 <- renderUI({
    #     actionButton(inputId = "go_include1", label = "Include")
    #   })
    # })
    # 
    # #If users click in include button, the selected residues will be considered in KVFinder run 
    # observeEvent(input$go_include1,{
    #   include_list <<- input$select_nonstand1
    #   #pdb_processed <<- deal_sele_nonstand(pdb_input = input$input_pdb$datapath,nonstand_list = get_nonstand, include_list = input$select_nonstand1)
    #   shinyalert("Residues successfully included.", type = "success", timer = 2000)
    # })
    
  } else{
    #Do not show any widgets related to nonstandard residues inclusion
    output$checkbox_nostand1 <- NULL
    output$note_text1 <- NULL
    output$ask_preprocess_include1 <- NULL
    output$preprocess_include1 <- NULL
  }
  
  
}