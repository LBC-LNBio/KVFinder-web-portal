#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyjs
#'
#' @noRd
#'

app_server <- function(input, output, session) {
  # url address to conexion. This is used in submition and check results functions.
  url_address <- "http://localhost:8081/"

  #-----------------------------------------------
  # initialize global variables to be used inside some funtions
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
  protein_col_scheme_list <- c()
  current_prot_color <- c()
  current_prot_color_scheme <- c()
  current_run_id <- c()
  result_pdb <- c()
  include_list <- c()
  get_nonstand <- NULL
  pdb_name_click_load <- "init"
  scheme_color_list <- list(
    "Residue index" = "residueindex",
    "Chain ID" = "chainid",
    "Hidrophobicity" = "hydrophobicity",
    "Secondary Structure" = "sstruc"
  )
  #---------------------------------------------

  # Point to KV help page when click in "More" button in main page
  observeEvent(input$more_button, {
    updateTabItems(session = session, inputId = "sidebarmenu", selected = "help_kv_sidebar")
  })

  # Create a list of lig names obtained from lig_name text box to guarantee that user will always reload the input input if changes the lig name
  observeEvent(input$lig_name, { #
    lig_name_list <<- c(lig_name_list, input$lig_name)
  })

  #------------------------------------------------------
  # Upload PDB section
  observeEvent(input$input_pdb, {
    # run process_upload of mod_server_upload module to create boxes and buttons of run mode
    process_upload(input = input, output = output, session = session)
    get_nonstand_check_upload <<- report_nonstand(pdb_input =input$input_pdb$datapath)
  })
  
  observeEvent(input$show_preview_upload, {
    print(input$input_pdb$datapath)
    print(pdb_name_click_load)
    print(get_nonstand)
    showModal(modalDialog(
      #title = tags$a('Structure preview', style = "text-align: right;" ),
      #NGLVieweROutput("structure_prev", width = "100%", height = "75vh"),
      if(!is.null(input$input_pdb)){
        #print(get_nonstand_check)
        renderNGLVieweR({
          # get input protein PDB with output cavities
          pdb <- input$input_pdb$datapath
          # create initial scene
          NGLVieweR(pdb) %>%
            # start protein with visible cartoon representation 
            addRepresentation("cartoon") %>%
            addRepresentation("ball+stick", param = list(sele = paste(get_nonstand_check_upload, collapse = " or "))) %>%
            # start cavity with points
            stageParameters(backgroundColor = "black") %>%
            setQuality("high") %>%
            setFocus(0)
        })
      }else{
        "No loaded structure to preview"
      },
      easyClose = TRUE,
      footer = NULL,
      size = 'l'
    ))
  })
  
  #-----------------------------------------------------

  #-----------------------------------------------------
  # Fetch PDB section
  observeEvent(input$send_pdb_id, {
    print(input$pdb_id)
    # save number of clicks in load button
    pdb_name_click_load <<- input$pdb_id
    # check if the PDB code is valid by using get_nonstand
    showModal(modalDialog("Loading and checking PDB...", footer = NULL, fade = FALSE))
    get_nonstand_check <<- report_nonstand(pdb_input = input$pdb_id)
    print(get_nonstand_check)
    removeModal()
    if (length(which(is.na(get_nonstand_check))) != 0) {
      shinyWidgets::sendSweetAlert(session = session, title = "Oops!", text = "Please insert a valid PDB ID.", type = "error")
    } else {
      print("PDB ID ok")
      process_fetch(input = input, output = output)
    }
    # run process_fetch of mod_server_fetch module to create boxes and buttons of run mode
    # process_fetch(input = input, output = output)
  })

  observeEvent(input$show_preview_fetch, {
    print(pdb_name_click_load)
    showModal(modalDialog(
      #title = tags$a('Structure preview', style = "text-align: right;" ),
      #NGLVieweROutput("structure_prev", width = "100%", height = "75vh"),
      if(pdb_name_click_load != 'init'){
        print(get_nonstand_check)
        renderNGLVieweR({
          # get input protein PDB with output cavities
          pdb <- input$pdb_id
          # create initial scene
          NGLVieweR(pdb) %>%
            # start protein with visible cartoon representation 
            addRepresentation("cartoon") %>%
            addRepresentation("ball+stick", param = list(sele = paste(get_nonstand_check, collapse = " or "))) %>%
            # start cavity with points
            stageParameters(backgroundColor = "black") %>%
            setQuality("high") %>%
            setFocus(0)
        })
      }else{
        "No loaded structure to preview"
      },
      easyClose = TRUE,
      footer = NULL,
      size = 'l'
    ))
  })

  #----------------------------------------------------
  #>>>>>>>>>>>>>> Submit Job <<<<<<<<<<<<<<<<<<<<<<<
  observeEvent(input$submit_button, {
    # Create modal dialog
    showModal(modalDialog("Submitting...", footer = NULL, fade = FALSE))
    # create a temporary empty ui output for NGL visualization and status card
    # this is necessary to avoid the previous state (hidden by hideElement) to be shown when running showElement function
    output[["structure"]] <- renderNGLVieweR({})
    output[["output_status1"]] <- NULL
    # Get current id
    current_run_id <<- submit_job(
      input = input,
      output = output,
      pdb_name_click_load = pdb_name_click_load,
      url_address = url_address,
      session = session
    )
    removeModal()
    # If result_pdb object is not null, i.e. the Check button was clicked previously,
    # all the buttons generated by Check results (next block of code), will be hidden every time we click on submit button.
    if (!is.null(result_pdb)) {
      hideElement(
        id = "download",
        time = 0
      )
      hideElement(
        id = "download2",
        time = 0
      )
      hideElement(
        id = "view_str",
        time = 0
      )
      hideElement(
        id = "table_out",
        time = 0
      )

      hideElement(
        id = "output_status1",
        time = 0
      )
      hideElement(
        id = "structure",
        time = 0
      )
      hideElement(
        id = "selection_pdb",
        time = 0
      )
      hideElement(
        id = "cavity_color",
        time = 0
      )
      hideElement(
        id = "protein_rep",
        time = 0
      )
      hideElement(
        id = "protein_color",
        time = 0
      )
      hideElement(
        id = "protein_color_scheme",
        time = 0
      )
      hideElement(
        id = "show_interface",
        time = 0
      )
      hideElement(
        id = "bg_color",
        time = 0
      )
      hideElement(
        id = "snapshot",
        time = 0
      )
      hideElement(
        id = "snapshot_title",
        time = 0
      )
      hideElement(
        id = "fullscreen",
        time = 0
      )
      hideElement(
        id = "fullscreen_title",
        time = 0
      )
    }
  })
  #----------------------------------------------------

  #----------------------------------------------------
  #>>>>>>>>>>>>>> Check Results <<<<<<<<<<<<<<<<<<<<<<<

  # Check results in the main Run KVFinder page
  observeEvent(input$go_to_check_results, {
    # Get and output the results
    result_pdb <<- check_results(input = input, output = output, run_id = current_run_id, is_pg2 = FALSE, url_address = url_address, session = session)
    # If result_pdb object is not null, i.e. the Check button was clicked in another previous run,
    # the function showElement below is executed to show the output status that was hidden by the submission button.
    if (!is.null(result_pdb)) {
      showElement(
        id = "output_status1",
        anim = FALSE,
        animType = "slide",
        time = 0,
        selector = NULL,
        asis = FALSE
      )
    }
    # Create a 'observe' to monitor the results by checking and automatically updating the status each 5s when in queued or running
    observe({
      result_pdb <<- check_results(input = input, output = output, run_id = current_run_id, is_pg2 = FALSE, url_address = url_address, session = session)
      if (length(result_pdb) == 1) { # if results_pdb corresponds to output status and not kvfinder results
        print(result_pdb)
        if (result_pdb %in% c("queued", "running")) {
          invalidateLater(5000) # means 5 seconds
        }
      } else { # in case of status completed or error, the check_results will not be updated each 5s
        # the hidden elements are also showed
        showElement(
          id = "download",
          time = 0
        )
        showElement(
          id = "download2",
          time = 0
        )
      }
    })
    # disable check button button to force the users to resubmit job and to avoid inconsistencies in the interface
    disable("go_to_check_results")
  })

  # Check results in the secondary page ("get latest results" page)
  observeEvent(input$check_loc_pg2, {
    # output[["structure_p2"]] <<- NULL
    result_pdb <<- check_results(input = input, output = output, run_id = input$insert_ID, is_pg2 = TRUE, url_address = url_address, session = session)
    # When check results button in page 2 is clicked, the structure visualization and all buttons related to NGL viewer will be hidden
    # to allow an update if the check button is used multiple times
    output[["structure_pg2"]] <- renderNGLVieweR({})
    hideElement(
      id = "structure_pg2",
      time = 0
    )
    hideElement(
      id = "selection_pdb_pg2",
      time = 0
    )
    hideElement(
      id = "cavity_color_pg2",
      time = 0
    )
    hideElement(
      id = "protein_rep_pg2",
      time = 0
    )
    hideElement(
      id = "protein_color_pg2",
      time = 0
    )
    hideElement(
      id = "protein_color_scheme_pg2",
      time = 0
    )
    hideElement(
      id = "show_interface_pg2",
      time = 0
    )
    hideElement(
      id = "bg_color_pg2",
      time = 0
    )
    hideElement(
      id = "snapshot_pg2",
      time = 0
    )
    hideElement(
      id = "snapshot_title_pg2",
      time = 0
    )
    hideElement(
      id = "fullscreen_pg2",
      time = 0
    )
    hideElement(
      id = "fullscreen_title_pg2",
      time = 0
    )
  })
  #----------------------------------------------------

  #----------------------------------------------------
  #>>>>>Visualize 3D results using NGLVieweR<<<<<<<<<<<

  # View in Run KVFinder main page
  # Click view to initialize the result visualization with the NGL engine
  observeEvent(input$view_str,
    {
      protein_rep_list <<- c() # always initialize an empty list of protein representations when clicking on view button
      protein_col_scheme_list <<- c() # always initialize an empty list of protein color scheme when clicking on view button
      # use "residue index" as the first protein color scheme
      protein_col_scheme_list <<- c(protein_col_scheme_list, "Residue index")
      # Create initial scene
      create_init_scene(input = input, output = output, result_pdb_list = result_pdb, is_pg2 = FALSE, scheme_color_list = scheme_color_list)
      # Show all elements that were hidden
      showElement(
        id = "structure",
        time = 0
      )
      showElement(
        id = "selection_pdb",
        time = 0
      )
      showElement(
        id = "cavity_color",
        time = 0
      )
      showElement(
        id = "protein_rep",
        time = 0
      )
      showElement(
        id = "protein_color",
        time = 0
      )
      showElement(
        id = "protein_color_scheme",
        time = 0
      )
      showElement(
        id = "show_interface",
        time = 0
      )
      showElement(
        id = "bg_color",
        time = 0
      )
      showElement(
        id = "snapshot",
        time = 0
      )
      showElement(
        id = "snapshot_title",
        time = 0
      )
      showElement(
        id = "fullscreen",
        time = 0
      )
      showElement(
        id = "fullscreen_title",
        time = 0
      )
      # disable view button to avoid user to click on it multiple times
      disable("view_str")
    },
    ignoreInit = FALSE,
    ignoreNULL = TRUE
  )

  # Create a work scene every time users click on protein representation selector and change biomolecular structure representation
  observeEvent(input$input_protein_rep,
    {
      # save the current representation
      current_rep <- input$input_protein_rep
      # fed the protein list of representations
      protein_rep_list <<- c(protein_rep_list, current_rep)
      # Create the work scene
      create_work_scene(input = input, output = output, protein_rep_list = protein_rep_list, protein_col_list = protein_col_list, protein_col_scheme_list = protein_col_scheme_list, result_pdb_list = result_pdb, is_pg2 = FALSE, scheme_color_list = scheme_color_list)
      # clean protein color selector
      updateSelectInput(session, "input_protein_color", # This update is made to clean the protein color selector
        selected = ""
      )
    },
    ignoreNULL = TRUE,
    ignoreInit = TRUE
  )

  # Select cavity to be visualized from clicking on cavity selector button
  observeEvent(input$select_cavity, {
    select_cav(input = input, output = output, result_pdb_list = result_pdb, is_pg2 = FALSE)
  })

  # change biomolecular structure color
  observeEvent(input$input_protein_color, {
    protein_col_list <<- change_str_color(input = input, output = output, protein_col_list = protein_col_list, is_pg2 = FALSE)
  })

  # change biomolecular structure color scheme
  observeEvent(input$input_protein_color_scheme,
    {
      protein_col_scheme_list <<- change_str_color_scheme(input = input, output = output, protein_col_scheme_list = protein_col_scheme_list, protein_rep_list = protein_rep_list, is_pg2 = FALSE, scheme_color_list = scheme_color_list)
      updateSelectInput(session, "input_protein_color",
        selected = ""
      )
    },
    ignoreNULL = TRUE
  )

  # change cavity color
  observeEvent(input$input_cavity_color, {
    change_cav_color(input = input, output = output, is_pg2 = FALSE)
  })

  # change background color
  observeEvent(input$input_bg_color, {
    change_bg_color(input = input, output = output, is_pg2 = FALSE)
  })

  # take a snapshot
  observeEvent(input$input_snapshot, {
    take_snapshot(input = input, output = output, is_pg2 = FALSE)
  })


  ##### View in Get latest results page (pg2)

  # Click view in the secondary page to initialize the result visualization with the NGL engine
  observeEvent(input$view_str_pg2, {
    print(protein_rep_list)
    protein_rep_list <<- c() # always initialize an empty list of protein representations when clicking on view button
    # protein_col_list <<- c(protein_col_list, "residueindex") #that one before!
    # protein_col_scheme_list <<- c(protein_col_scheme_list, "white")
    # now
    protein_col_scheme_list <<- c() # always initialize an empty list of protein color scheme when clicking on view button
    # use "residue index" as the first protein color scheme
    protein_col_scheme_list <<- c(protein_col_scheme_list, "Residue index")

    # Create initial scene
    create_init_scene(input = input, output = output, result_pdb_list = result_pdb, is_pg2 = TRUE, scheme_color_list = scheme_color_list)
    # Show visualization states and buttons if they are hided by the previous results checking
    showElement(
      id = "structure_pg2",
      time = 0
    )
    showElement(
      id = "selection_pdb_pg2",
      time = 0
    )
    showElement(
      id = "cavity_color_pg2",
      time = 0
    )
    showElement(
      id = "protein_rep_pg2",
      time = 0
    )
    showElement(
      id = "protein_color_pg2",
      time = 0
    )
    showElement(
      id = "protein_color_scheme_pg2",
      time = 0
    )
    showElement(
      id = "show_interface_pg2",
      time = 0
    )
    showElement(
      id = "bg_color_pg2",
      time = 0
    )
    showElement(
      id = "snapshot_pg2",
      time = 0
    )
    showElement(
      id = "snapshot_title_pg2",
      time = 0
    )
    showElement(
      id = "fullscreen_pg2",
      time = 0
    )
    showElement(
      id = "fullscreen_title_pg2",
      time = 0
    )
    disable("view_str_pg2")
  })



  # Create a work scene every time users click on protein representation selector and change biomolecular structure representation
  observeEvent(input$input_protein_rep_pg2,
    {
      # save the current representation
      current_rep <- input$input_protein_rep_pg2
      # create a list of representations
      protein_rep_list <<- c(protein_rep_list, current_rep)
      # Create work scene
      create_work_scene(input = input, output = output, protein_rep_list = protein_rep_list, protein_col_list = protein_col_list, protein_col_scheme_list = protein_col_scheme_list, result_pdb_list = result_pdb, is_pg2 = TRUE, scheme_color_list = scheme_color_list)

      # clean protein color selector
      updateSelectInput(session, "input_protein_color_pg2", # This updation is made to clean the protein color selector
        selected = ""
      )
    },
    ignoreNULL = TRUE,
    ignoreInit = FALSE
  )

  # Select cavity to be visualized from clicking on cavity selector button
  observeEvent(input$select_cavity_pg2, {
    select_cav(input = input, output = output, result_pdb_list = result_pdb, is_pg2 = TRUE)
  })
  # change biomolecular structure color
  observeEvent(input$input_protein_color_pg2,
    {
      protein_col_list <<- change_str_color(input = input, output = output, protein_col_list = protein_col_list, is_pg2 = TRUE)
    },
    ignoreInit = F,
    ignoreNULL = T
  )
  # change biomolecular structure color scheme
  observeEvent(input$input_protein_color_scheme_pg2, {
    protein_col_scheme_list <<- change_str_color_scheme(input = input, output = output, protein_col_scheme_list = protein_col_scheme_list, is_pg2 = TRUE, scheme_color_list = scheme_color_list)
    updateSelectInput(session, "input_protein_color_pg2", # This updation is made to clean the protein color selector
      selected = ""
    )
  })
  # change cavity color
  observeEvent(input$input_cavity_color_pg2, {
    change_cav_color(input = input, output = output, is_pg2 = TRUE)
  })
  # change background color
  observeEvent(input$input_bg_color_pg2, {
    change_bg_color(input = input, output = output, is_pg2 = TRUE)
  })
  # take a snapshot
  observeEvent(input$input_snapshot_pg2, {
    take_snapshot(input = input, output = output, is_pg2 = TRUE)
  })

  #----------------------------------------------------
}
