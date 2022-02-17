#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyjs
#'
#' @noRd
#' 

app_server <- function( input, output, session ) {
  
  #-----------------------------------------------
  #create global variables
  pdb_str <- NULL
  retrieve_input_pdb <- NULL
  cav_out_names <- NULL
  cav_list <- NULL
  result_toml <- NULL
  protein_rep_list <- c()
  pdb_processed <- NULL
  pdb_ligand_processed <- NULL
  run_mode_list <- c()
  lig_name_list <- c()
  get_run_id <- c()
  run_id_list <- c()
  protein_col_list <- c()
  current_prot_color <- c()
  
  current_run_id <- c()
  result_pdb <- c()
  
  include_list <- c()
  get_nonstand <- NULL
  
  pdb_name_click_load <- "init"
  #---------------------------------------------
  
  
  #Point to KV help page when click in "More" button in main page 
  observeEvent(input$more_button,{
    updateTabItems(session = session, inputId = "sidebarmenu", selected = "help_kv_sidebar") 
  })
  
  #Create a list of lig names obtained from lig_name text box to guarantee that user will always reload the input input if changes the lig name
  observeEvent(input$lig_name, { #
    lig_name_list <<- c(lig_name_list,input$lig_name)
  })
  
  #------------------------------------------------------
  #Upload PDB section 
  observeEvent(input$input_pdb, {
    process_upload(input = input, output = output)
    
    #run_mode_list <<- c()
    #lig_name_list <<- c()

  #   if(input$run_mode == "lig_mode"){
  #     #process PDB according to ligand mode
  #     process_upload_ligmode(input = input, output = output)
  #   } else { #not ligand mode
  #     #process PDB according to all the other modes: default, customized and box mode.
  #     process_upload(input = input, output = output)
  #   }
  #   
   })
  #-----------------------------------------------------
  
  #-----------------------------------------------------
  #Fetch PDB section
  observeEvent(input$send_pdb_id, {
    #run_mode_list <<- c()
    #lig_name_list <<- c()
    pdb_name_click_load <<- input$pdb_id
    
    #check if the PDB code is valid by using get_nonstand  
    showModal(modalDialog("Loading and checking PDB...", footer=NULL,fade = FALSE))
    get_nonstand_check <- report_nonstand(pdb_input = input$pdb_id)
    removeModal()
    if (is.na(get_nonstand_check)){
      shinyalert("Oops!", "Please insert a valid PDB ID.", type = "error")
    } else{
      print("PDB ID ok")
    }
    
    process_fetch(input = input, output = output)
    
    # if(input$run_mode == "lig_mode"){
    #   #process PDB according to ligand mode
    #   process_fetch_ligmode(input = input, output = output)
    # } else { #not ligand mode
    #   #process PDB according to all the other modes: default, customized and box mode.
    #   process_fetch(input = input, output = output)
    # }
  })
  
  #----------------------------------------------------
  #Submit section
  observeEvent(input$submit_button, {
      current_run_id <<- submit_job(input = input, 
                                   output = output,
                                   pdb_name_click_load = pdb_name_click_load)
  })
  #----------------------------------------------------
    
  #----------------------------------------------------
  #>>>>>>>>>>>>>> Check Results <<<<<<<<<<<<<<<<<<<<<<<
  
  #Check results in Run KVFinder page
  observeEvent(input$go_to_check_results, {
    result_pdb <<- check_results(input = input, output = output, run_id = current_run_id, is_pg2 = FALSE)
    
  })
  #Check results in Get latest results page (pg2)
  observeEvent(input$check_loc_pg2, {
    result_pdb <<- check_results(input = input, output = output, run_id = input$insert_ID, is_pg2 = TRUE)
  })
  #----------------------------------------------------
  
  #----------------------------------------------------
  #>>>>>Visualize 3D results using NGLVieweR<<<<<<<<<<<
  
  #View in Run KVFinder main page
  
  #Click view to visualize
  observeEvent(input$view_str, {
    protein_rep_list <<- c() #always zero rep list when click view
    #current states
    protein_col_list <<- c(protein_col_list, "residueindex")
    #Create initial scene
    create_init_scene(input = input, output = output, result_pdb_list = result_pdb, is_pg2 = FALSE)
    disable("view_str")
  })
  #Create a work scene and change biomolecular structure representation 
  observeEvent(input$input_protein_rep,{
    #save the current representatio
    current_rep <- input$input_protein_rep
    #create a list of representations 
    protein_rep_list <<- c(protein_rep_list, current_rep)
    #Create a work scene
    create_work_scene(input = input, output = output, protein_rep_list = protein_rep_list, protein_col_list = protein_col_list,result_pdb_list = result_pdb, is_pg2 = FALSE)
  }, ignoreNULL = TRUE, ignoreInit = FALSE)
  #Select cavity to be visualized 
  observeEvent(input$select_cavity, {
    select_cav(input = input, output = output, result_pdb_list = result_pdb, is_pg2 = FALSE)
  })
  #change biomolecular structure color
  observeEvent(input$input_protein_color, {
    protein_col_list <<- change_str_color(input = input, output = output, protein_col_list = protein_col_list, is_pg2 = FALSE)
  })
  #change cavity color
  observeEvent(input$input_cavity_color, {
    change_cav_color(input = input, output = output, is_pg2 = FALSE)
  })
  #change background color
  observeEvent(input$input_bg_color, {
    change_bg_color(input = input, output = output, is_pg2 = FALSE)
  })
  #take a snapshot
  observeEvent(input$input_snapshot, {
    take_snapshot(input = input, output = output, is_pg2 = FALSE)
  })
  
  #View in Get latest results page (pg2 )
  
  #Click view to visualize
  observeEvent(input$view_str_pg2, {
    protein_rep_list <<- c() #always zero rep list when click view
    #protein_col_list <<- c(protein_col_list, "residueindex")
    protein_col_list <<- c()
    #Create initial scene
    create_init_scene(input = input, output = output, result_pdb_list = result_pdb, is_pg2 = TRUE)
    disable("view_str_pg2")
  })
  #Create a work scene and change biomolecular structure representation 
  observeEvent(input$input_protein_rep_pg2,{
    #save the current representatio
    current_rep <- input$input_protein_rep_pg2
    #create a list of representations 
    protein_rep_list <<- c(protein_rep_list, current_rep)
    #Create work scene
    create_work_scene(input = input, output = output, protein_rep_list = protein_rep_list, protein_col_list = protein_col_list,result_pdb_list = result_pdb, is_pg2 = TRUE)
  }, ignoreNULL = TRUE, ignoreInit = FALSE)
  #Select cavity to be visualized
  observeEvent(input$select_cavity_pg2, {
    select_cav(input = input, output = output, result_pdb_list = result_pdb, is_pg2 = TRUE)
  })
    #change biomolecular structure color
    observeEvent(input$input_protein_color_pg2, {
    protein_col_list <<- change_str_color(input = input, output = output, protein_col_list = protein_col_list, is_pg2 = TRUE)
    })
    #change cavity color
    observeEvent(input$input_cavity_color_pg2, {
    change_cav_color(input = input, output = output, is_pg2 = TRUE)
    })
    #change background color
    observeEvent(input$input_bg_color_pg2, {
    change_bg_color(input = input, output = output, is_pg2 = TRUE)
    })
    #take a snapshot
    observeEvent(input$input_snapshot_pg2, {
    take_snapshot(input = input, output = output, is_pg2 = TRUE)
    })

  #----------------------------------------------------
  
  
}
