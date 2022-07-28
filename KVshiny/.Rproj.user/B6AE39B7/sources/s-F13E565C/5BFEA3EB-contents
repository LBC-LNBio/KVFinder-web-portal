#' Create radio buttons of the run mode in main Run KVFinder page 
#' 
#' @import shiny
#' @import bs4Dash
#' 
#' @export

choose_run_mode <- function(){
  #create choose run mode card
  
  #Choose run mode 
  run_mode_card <- bs4Card(
                      title = "Step 2. Choose run mode",
                      id = "run_mode_box",
                      collapsible = TRUE,
                      collapsed = TRUE,
                      closable = FALSE,
                      solidHeader = TRUE,
                      elevation = 2,
                      headerBorder = TRUE,
                      width = 9,
                      fluidRow(
                        column(5,
                               #radio buttons of run mode
                               create_radio_mode()),
                        column(7,
                               #Whole structure - Default parameters mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                               conditionalPanel( condition = "input.run_mode == 'mode_def'",
                                                 column(8, align = "center",
                                                        tags$h5("KVFinder parameters")),
                                                 splitLayout(
                                                   disabled(
                                                     bs4Dash::tooltip(
                                                       tags$div(class="disabled-div",
                                                                kv_params(id = "mode_def",input_type = "probe_in")),
                                                       title = "A smaller probe that rolls around the target protein. Usually set to a water molecule (1.4 Å). Probe in must be smaller than probe out.",placement = "bottom")),
                                                   disabled(
                                                     bs4Dash::tooltip(
                                                       kv_params(id = "mode_def",input_type = "probe_out"),
                                                       title = "A larger probe that rolls around the target protein, which depending on the characteristics of the target structure, user may adjust probe size. Probe out must be larger than probe in.",placement = "bottom"))),
                                                 splitLayout(
                                                   disabled(
                                                     bs4Dash::tooltip(
                                                       kv_params(id = "mode_def",input_type = "removal_dist"),
                                                       title = "Defines a distance to be removed from the cavity boundary. This length is converted to grid units by dividing it by grid spacing.",placement = "bottom")),
                                                   disabled(  
                                                     bs4Dash::tooltip(
                                                       kv_params(id = "mode_def",input_type = "VC_input"),
                                                       title = "Defines a filter to exclude cavities with smaller volumes than this limit. Useful to exclude uninteresting cavities from results.",placement = "bottom")))
                                                 
                               ),
                               #Whole structure - Customized parameters mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                               conditionalPanel( condition = "input.run_mode == 'mode_cust'",
                                                 column(8, align = "center",
                                                        tags$h5("KVFinder parameters")),
                                                 splitLayout(
                                                   bs4Dash::tooltip(
                                                     kv_params(id = "mode_cust",input_type = "probe_in"),
                                                     title = "A smaller probe that rolls around the target protein. Usually set to a water molecule (1.4 Å). Probe in must be smaller than probe out.",placement = "bottom"),
                                                   bs4Dash::tooltip(
                                                     kv_params(id = "mode_cust",input_type = "probe_out"),
                                                     title = "A larger probe that rolls around the target protein, which depending on the characteristics of the target structure, user may adjust probe size. Probe out must be larger than probe in.",placement = "bottom")),
                                                 splitLayout(
                                                   bs4Dash::tooltip(
                                                     kv_params(id = "mode_cust",input_type = "removal_dist"),
                                                     title = "Defines a distance to be removed from the cavity boundary. This length is converted to grid units by dividing it by grid spacing.",placement = "bottom"),
                                                   bs4Dash::tooltip(
                                                     kv_params(id = "mode_cust",input_type = "VC_input"),
                                                     title = "Defines a filter to exclude cavities with smaller volumes than this limit. Useful to exclude uninteresting cavities from results.",placement = "bottom"))
                               ),
                               # Around target molecule - Ligand mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                               conditionalPanel( condition = "input.run_mode == 'lig_mode'",
                                                 column(5,
                                                        #uiOutput("show_lig_name")),
                                                        selectInput(inputId = "lig_name",
                                                                    label = "Ligand or molecule name:",
                                                                    choices = NULL,
                                                                    selected = NULL)),
                                                 column(8, align = "center",
                                                        tags$h5("KVFinder parameters")),
                                                 
                                                 splitLayout(
                                                   bs4Dash::tooltip(
                                                     kv_params(id = "lig_mode",input_type = "probe_in"),
                                                     title = "A smaller probe that rolls around the target protein. Usually set to a water molecule (1.4 Å).",placement = "bottom"),
                                                   bs4Dash::tooltip(
                                                     kv_params(id = "lig_mode",input_type = "probe_out"),
                                                     title = "A larger probe that rolls around the target protein, which depending on the characteristics of the target structure, user may adjust probe size.",placement = "bottom"),
                                                   bs4Dash::tooltip(numericInput(
                                                     inputId = "lig_cutoff",
                                                     label = "Ligand cutoff (Å):",
                                                     value = 5,
                                                     min = 0,
                                                     max = 1000,
                                                     step = 1,
                                                     width = 60),title = "Defines the search radius from the ligand structure.",placement = "bottom")),
                                                 
                                                 splitLayout(
                                                   bs4Dash::tooltip(
                                                     kv_params(id = "lig_mode",input_type = "removal_dist"),
                                                     title = "Defines a distance to be removed from the cavity boundary. This length is converted to grid units by dividing it by grid spacing.",placement = "bottom"),
                                                   bs4Dash::tooltip(
                                                     kv_params(id = "lig_mode",input_type = "VC_input"),
                                                     title = "Defines a filter to exclude cavities with smaller volumes than this limit. Useful to exclude uninteresting cavities from results.",placement = "bottom"))
                                                 
                               ),
                               # Around target residues - Box mode >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                               conditionalPanel( condition = "input.run_mode == 'box_mode'",
                                                 textInput(inputId = "box_residues",
                                                           label = "Target residues:",
                                                           placeholder = "ex: 10_A;11_A;12_A",
                                                           width = 200),
                                                 column(8, align = "center",
                                                        tags$h5("KVFinder parameters")),
                                                 splitLayout(
                                                   bs4Dash::tooltip(
                                                     kv_params(id = "box_mode",input_type = "probe_in"),
                                                     title = "A smaller probe that rolls around the target protein. Usually set to a water molecule (1.4 Å). Probe in must be smaller than probe out.",placement = "bottom"),
                                                   bs4Dash::tooltip(
                                                     kv_params(id = "box_mode",input_type = "probe_out"),
                                                     title = "A larger probe that rolls around the target protein, which depending on the characteristics of the target structure, user may adjust probe size. Probe out must be larger than probe in.",placement = "bottom"),
                                                   bs4Dash::tooltip(numericInput(
                                                     inputId = "padding_value",
                                                     label = "Padding (Å):",
                                                     value = 3.5,
                                                     min = 0,
                                                     max = 5,
                                                     step = 1,
                                                     width = 60),
                                                     title = "Defines padding around the selection which the box will be created.",placement = "bottom")),
                                                 splitLayout(
                                                   bs4Dash::tooltip(
                                                     kv_params(id = "box_mode",input_type = "removal_dist"),
                                                     title = "Defines a distance to be removed from the cavity boundary. This length is converted to grid units by dividing it by grid spacing.",placement = "bottom"),
                                                   bs4Dash::tooltip(
                                                     kv_params(id = "box_mode",input_type = "VC_Input"),
                                                     title = "Defines a filter to exclude cavities with smaller volumes than this limit. Useful to exclude uninteresting cavities from results.",placement = "bottom"))))),
                      #Run mode info side bar
                      sidebar = boxSidebar(
                        id = "sidebar_run_mode",
                        p("In this box you need to set the mode of your KVFinder run."),
                        p("In Whole Structure mode with default parameters, a preset of KVFinder parameters will be used to detect cavities in the whole biomolecular structure."),
                        p("In Whole Structure mode with customized parameters, you can modify the KVFinder parameters to detect cavities in the whole structure. A help text is available when the you moves the mouse over the parameter."),
                        p("The cavity detection can be focused on the region of the structure occupied by a target molecule. This mode limits the search space around a target molecule."),
                        p("The cavity detection can also be focused on specific regions and residues of the target structure. This mode explores closed regions with a custom box, which is drawn by selecting residues of the target structure."),
                        icon = icon("info"))
                    )
  
  return(run_mode_card)
  
}