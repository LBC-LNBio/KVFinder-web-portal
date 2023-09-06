#' Create radio buttons of the run mode in main Run KVFinder page
#'
#' @import shiny
#' @import bs4Dash
#'
#' @export

choose_run_mode <- function() {

  # Choose run mode
  run_mode_card <- bs4Card(
    
    # bs4Card configuration
    title = tags$p(
      tags$strong("Step 2."), 
      "Choose run mode", 
      style = "margin-top: 0px; margin-bottom: 0px; padding-top: 0px; padding-bottom: 0px; color: white;"
    ), # Optional title
    id = "run_mode_box", # Get the state of the card
    collapsible = TRUE, # If TRUE, display a button in the upper right that allows the user to collapse the box.
    collapsed = TRUE, # If TRUE, start collapsed. This must be used with collapsible=TRUE.
    closable = FALSE, # If TRUE, display a button in the upper right that allows the user to close the box.
    solidHeader = TRUE, # Should the header be shown with a solid color background?
    elevation = 2, # Card elevation.
    headerBorder = TRUE, # Whether to display a border between the header and body. 
    width = 9, # The width of the box, using the Bootstrap grid system. This is used for row-based layouts. The overall width of a region is 12, so the default width of 4 occupies 1/3 of that width.
    
    # Main content
    fluidRow(
      
      # Type of run modes radio buttons
      column(
        5,
        radioButtons(
          "run_mode", 
          "Detect cavities in:",
          c(
            "Whole structure (default)" = "mode_def",
            "Whole structure (customized)" = "mode_cust",
            "Around target molecule" = "lig_mode",
            "Around target residues" = "box_mode"
          )
        ),
        style="display: flex; justify-content: center; align-items: center; text-align: justify;"
      ),
      
      column(
        7,
        
        # Whole structure (default) 
        conditionalPanel(
          condition = "input.run_mode == 'mode_def'",

          # KVFinder-web parameters
          column(
            8,
            align = "center",
            tags$h5(
              tags$strong("KVFinder-web parameters"),
              style = "text-align: center; margin-top: 0px; margin-bottom: 0px; padding-top: 0px; padding-bottom: 0px;"
            ),
          ),          
          
          # Upper line
          fluidRow(
            # Probe In (A)
            column(
              6,
              disabled(
                tooltip(
                  kv_params(
                    id = "mode_def",
                    input_type = "probe_in"
                  ),
                  title = "A smaller probe that rolls around the target biomolecular structure, typically set to the size of a water molecule (1.4 Å). The 'Probe in' size must be smaller than the 'Probe out' size.", 
                  placement = "bottom"
                )
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center;"
            ),

          # Probe Out (A)
            column(
              6,
              disabled(
                tooltip(
                  kv_params(
                    id = "mode_def", 
                    input_type = "probe_out"
                  ),
                  title = "A larger probe that rolls around the target biomolecular structure, and users have the option to adjust its size based on the characteristics of the target structure. The 'Probe out' size must be larger than the 'Probe in' size.", 
                  placement = "bottom"
                )
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center;"
            ),
            style="display: flex; justify-content: center; align-items: center;"
          ),

          # Bottom line
          fluidRow(
            # Removal distance (A)
            column(
              6,
              disabled(
                tooltip(
                  kv_params(
                    id = "mode_def",
                    input_type = "removal_dist"
                  ),
                  title = "Specifies a length to be subtracted from the cavity boundary. This length is converted into grid units by dividing it by the grid spacing (0.6 Å).",
                  placement = "bottom"
                )
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center; white-space: nowrap;"
            ),

            # Volume cutoff (Å^3)
            column(
              6,
              disabled(
                tooltip(
                  kv_params(
                    id = "mode_def",
                    input_type = "VC_input"
                  ),
                  title = "Sets a filter to exclude cavities with volumes smaller than this limit. This is useful for excluding uninteresting cavities from the results.", 
                  placement = "bottom"
                )
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center; white-space: nowrap;"
            ),
            style="display: flex; justify-content: center; align-items: center; white-space: nowrap;"
          )
        ),
        
        # Whole structure (customized)
        conditionalPanel(
          condition = "input.run_mode == 'mode_cust'",
          
          # KVFinder-web parameters
          column(
            8,
            align = "center",
            tags$h5(
              tags$strong("KVFinder-web parameters"),
              style = "text-align: center; margin-top: 0px; margin-bottom: 0px; padding-top: 0px; padding-bottom: 0px;"
            ),
          ),

          # Upper line
          fluidRow(
            # Probe In (A)
            column(
              6,
              tooltip(
                kv_params(
                  id = "mode_cust",
                  input_type = "probe_in"
                ),
                title = "A smaller probe that rolls around the target biomolecular structure, typically set to the size of a water molecule (1.4 Å). The 'Probe in' size must be smaller than the 'Probe out' size.", 
                placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center;"
            ),

            # Probe Out (A)
            column(
              6,
              tooltip(
                kv_params(
                  id = "mode_cust",
                  input_type = "probe_out"
                ),
                title = "A larger probe that rolls around the target biomolecular structure, and users have the option to adjust its size based on the characteristics of the target structure. The 'Probe out' size must be larger than the 'Probe in' size.",
                placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center;"
            ),
          ),

          # Bottom line
          fluidRow(
            # Removal distance (A)
            column(
              6,
              tooltip(
                kv_params(
                  id = "mode_cust",
                  input_type = "removal_dist"
                ),
                title = "Specifies a length to be subtracted from the cavity boundary. This length is converted into grid units by dividing it by the grid spacing (0.6 Å).",
                placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center; white-space: nowrap;"
            ),

            # Volume cutoff (Å^3)
            column(
              6,
              tooltip(
                kv_params(
                  id = "mode_cust",
                  input_type = "VC_input"
                ),
                title = "Sets a filter to exclude cavities with volumes smaller than this limit. This is useful for excluding uninteresting cavities from the results.", 
                placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center; white-space: nowrap;"
            ),
            style="display: flex; justify-content: center; align-items: center; white-space: nowrap;"
          )
        ),
        
        # Around target molecule (Ligand adjustment mode)
        conditionalPanel(
          condition = "input.run_mode == 'lig_mode'",
          
          # KVFinder-web parameters
          column(
            8,
            align = "center",
            tags$h5(
              tags$strong("KVFinder-web parameters"),
              style = "text-align: center; margin-top: 0px; margin-bottom: 0px; padding-top: 0px; padding-bottom: 0px;"
            ),
          ),

          # Upper line
          fluidRow(
            # Ligand or molecule name
            column(
              6,
              tooltip(
                selectInput(
                  inputId = "lig_name",
                  label = "Ligand or molecule:",
                  choices = NULL,
                  selected = NULL,
                  width = "100px",
                ),
                title = "Selects the ligand or molecule to be used as the reference for cavity detection.",
                placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center; white-space: nowrap; margin-top: 1rem; margin-bottom: -1rem;"
            ),

            # Ligand Cutoff (A)
            column(
              6,
              tooltip(
                numericInput(
                  inputId = "lig_cutoff",
                  label = "Ligand cutoff (Å):",
                  value = 5,
                  min = 0,
                  max = 1000,
                  step = 1,
                  width = "100px"
                ), 
                title = "Defines the search radius from the ligand or molecule structure.",
                placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center; white-space: nowrap; margin-bottom: -1rem;"
            ),
          ),

          # Medium line
          fluidRow(
            # Probe In (A)
            column(
              6,
              tooltip(
                kv_params(
                  id = "lig_mode",
                  input_type = "probe_in"
                ),
                title = "A smaller probe that rolls around the target biomolecular structure, typically set to the size of a water molecule (1.4 Å). The 'Probe in' size must be smaller than the 'Probe out' size.", 
                placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center;"
            ),

            # Probe Out (A)
            column(
              6,
              tooltip(
                kv_params(
                  id = "lig_mode",
                  input_type = "probe_out"
                ),
                title = "A larger probe that rolls around the target biomolecular structure, and users have the option to adjust its size based on the characteristics of the target structure. The 'Probe out' size must be larger than the 'Probe in' size.",
                placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center;"
            ),
            style="display: flex; justify-content: center; align-items: center; white-space: nowrap;"
          ),

          # Bottom line
          fluidRow(
            # Removal distance (A)
            column(
              6,
              tooltip(
                kv_params(
                  id = "lig_mode",
                  input_type = "removal_dist"
                ),
                title = "Specifies a length to be subtracted from the cavity boundary. This length is converted into grid units by dividing it by the grid spacing (0.6 Å).",
                placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center; white-space: nowrap;"
            ),

            # Volume cutoff (Å^3)
            column(
              6,
              tooltip(
                kv_params(
                  id = "lig_mode",
                  input_type = "VC_input"
                ),
                title = "Sets a filter to exclude cavities with volumes smaller than this limit. This is useful for excluding uninteresting cavities from the results.", 
                placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center; white-space: nowrap;"
            ),
            style="display: flex; justify-content: center; align-items: center; white-space: nowrap;"
          )
        ),
        
        # Around target residues (Box mode)
        conditionalPanel(
          condition = "input.run_mode == 'box_mode'",
          
          # KVFinder-web parameters
          column(
            8,
            align = "center",
            tags$h5(
              tags$strong("KVFinder-web parameters"),
              style = "text-align: center; margin-top: 0px; margin-bottom: 0px; padding-top: 0px; padding-bottom: 0px;"
            ),
          ),

          # Upper line
          fluidRow(
            # Target residues
            column(
              6,
              tooltip(
                textInput(
                  inputId = "box_residues",
                  label = "Target residues:",
                  placeholder = "ex: 10_A;11_A;12_A",
                  width = "200px"
                ),
                title = "Specifies a list of target residues using the following format: 10_A;11_A;12_A.",
                placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center; white-space: nowrap;"
            ),

            # Padding (A)
            column(
              6,
              tooltip(
                numericInput(
                  inputId = "padding_value",
                  label = "Padding (Å):",
                  value = 3.5,
                  min = 0.0,
                  max = 5.0,
                  step = 1.0,
                  width = "100px"
                ),
                title = "Defines padding around the selection which the box will be created.", placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center;"
            ),
          ),

          # Medium line
          fluidRow(
            # Probe In (A)
            column(
              6,
              tooltip(
                kv_params(
                  id = "box_mode",
                  input_type = "probe_in"
                ),
                title = "A smaller probe that rolls around the target biomolecular structure, typically set to the size of a water molecule (1.4 Å). The 'Probe in' size must be smaller than the 'Probe out' size.", 
                placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center;"
            ),

            # Probe Out (A)
            column(
              6,
              tooltip(
                kv_params(
                  id = "box_mode",
                  input_type = "probe_out"
                ),
                title = "A larger probe that rolls around the target biomolecular structure, and users have the option to adjust its size based on the characteristics of the target structure. The 'Probe out' size must be larger than the 'Probe in' size.",
                placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center;"
            ),
            style="display: flex; justify-content: center; align-items: center; white-space: nowrap;"
          ),

          # Bottom line
          fluidRow(
            # Removal distance (A)
            column(
              6,
              tooltip(
                kv_params(
                  id = "box_mode",
                  input_type = "removal_dist"
                ),
                title = "Specifies a length to be subtracted from the cavity boundary. This length is converted into grid units by dividing it by the grid spacing (0.6 Å).",
                placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center; white-space: nowrap;"
            ),

            # Volume cutoff (Å^3)
            column(
              6,
              tooltip(
                kv_params(
                  id = "box_mode",
                  input_type = "VC_input"
                ),
                title = "Sets a filter to exclude cavities with volumes smaller than this limit. This is useful for excluding uninteresting cavities from the results.", 
                placement = "bottom"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center; white-space: nowrap;"
            ),
            style="display: flex; justify-content: center; align-items: center; white-space: nowrap;"
          )
        ),
      )
    ),

    # Run mode info side bar
    sidebar = boxSidebar(
      id = "sidebar_run_mode",
      icon = icon("info"),
      tags$p(
        "In this card, you can choose and configure the mode of your KVFinder-web job. There are four available modes:",
        tags$br(),
        tags$strong("1. Whole protein mode (default):", style="margin-left: 15px"),
        "KVFinder-web will use preset parameters to detect cavities across the entire biomolecular structure.",
        tags$br(),
        tags$strong("2. Whole protein mode (customized):", style="margin-left: 15px"),
        "This mode allows you to tailor the parameters for cavity detection across the entire biomolecular structure. Helpful tooltips are provided when you hover over each parameter.",
        tags$br(),
        tags$strong("3. Around target molecule mode:", style="margin-left: 15px"),
        "This mode specifically detects cavities around a chosen target molecule, focusing the search on the region surrounding that molecule.",
        tags$br(),
        tags$strong("4. Around target residues mode:", style="margin-left: 15px"),
        "In this mode, you can focus on detecting cavities within a custom box defined by selecting specific residues within the target biomolecular structure.",
      ),
      style = "text-align: justify; margin-top: 0px; margin-bottom: 0px; padding-top: 0px; padding-bottom: 0px; margin-right: 0.5rem;"     
    )
  )

  return(run_mode_card)

}
