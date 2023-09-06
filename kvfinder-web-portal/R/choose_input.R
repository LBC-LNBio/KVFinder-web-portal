#' Create radio buttons of the run mode in main Run KVFinder page
#'
#' @import shiny
#' @import bs4Dash
#'
#' @export
#' 


choose_input <- function() {
  
  input_card <- bs4Card(
    
    # bs4Card configuration
    title = tags$p(
      tags$strong("Step 1."), 
      "Choose input", 
      style = "margin-top: 0px; margin-bottom: 0px; padding-top: 0px; padding-bottom: 0px; color: white;"
    ), # Optional title
    id = "run_mode_box", # Get the state of the card
    collapsible = TRUE, # If TRUE, display a button in the upper right that allows the user to collapse the box.
    collapsed = FALSE, # If TRUE, start collapsed. This must be used with collapsible=TRUE.
    closable = FALSE, # If TRUE, display a button in the upper right that allows the user to close the box.
    solidHeader = TRUE, # Should the header be shown with a solid color background?
    elevation = 2, # Card elevation.
    headerBorder = TRUE, # Whether to display a border between the header and body. 
    width = 9, # The width of the box, using the Bootstrap grid system. This is used for row-based layouts. The overall width of a region is 12, so the default width of 4 occupies 1/3 of that width.
    
    # Main content
    fluidRow(
      
      # Type of input radio buttons
      column(
        3,
        radioButtons(
          "input_type",
          "Type of input:",
          c(
            "Fetch from PDB" = "pdb_from_id",
            "Upload PDB file" = "pdb_from_file"
          ),
        ),
        style="display: flex; justify-content: center; align-items: center;"
      ),
      
      # Conditional panel for fetch and upload modes
      column(
        9,

        # Fetch mode
        conditionalPanel(
          condition = "input.input_type == 'pdb_from_id'",
          fluidRow(
            column(
              4,
              textInput(
                inputId = "pdb_id",
                label = "PDB ID:",
                placeholder = "ex: 1PRG",
                width = "110px"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center;"
            ),
            column(
              3,
              actionButton(
                inputId = "send_pdb_id",
                label = "Load",
                icon = icon("share-square"),
                width = "110px"
              ),
              style="display: flex; justify-content: center; align-items: center;"       
            ),
            column(
              3,
              actionButton(
                inputId = "show_preview_fetch",
                label = "Preview",
                icon = icon("search"),
                width = "110px"
              ),
              style="display: flex; justify-content: center; align-items: center;"  ,  
            ),
          ),
        ),

        # Upload mode
        conditionalPanel(
          condition = "input.input_type == 'pdb_from_file'",
          fluidRow(
            column(
              9,
              fileInput(
                inputId = "input_pdb",
                label = "Upload PDB file:",
                accept = ".pdb",
                width = "300px"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center;"
            ),
            column(
              3,
              actionButton(
                inputId = "show_preview_upload",
                label = "Preview",
                icon = icon("search"),
                width = "110px"
              ),
              style="display: flex; justify-content: center; align-items: center; text-align: center;",           
            )
          ),
        ),
        style="display: flex; justify-content: center; align-items: center;" 
      ),
    ),

    # Check for nonstandard residues in Fetch mode 
    fluidRow(
      conditionalPanel(
        condition = "input.input_type == 'pdb_from_id'",
        column(
          12,
          uiOutput("note_text2"),
          uiOutput("checkbox_nostand2", width = "100%")
        )
      ),
      style="display: flex; justify-content: center; align-items: center; margin-left: 1rem; margin-right: 1rem;" 
    ),

    # Check for nonstandard residues in Upload PDB mode 
    fluidRow(
      conditionalPanel(
        condition = "input.input_type == 'pdb_from_file'",
        column(
          12,
          uiOutput("note_text1"),
          uiOutput("checkbox_nostand1", width = "100%")
        )
      ),
      style="display: flex; justify-content: center; align-items: center; margin-left: 1rem; margin-right: 1rem;" 
    ),

    # Help sidebar
    sidebar = boxSidebar(
      id = "input_pdb_helpbar",
      icon = icon("info"),
      tags$p(
        "Cavity detection can be perfomed in two ways:",
        tags$br(),
        tags$strong("1.", style="margin-left: 15px"), 
        "Fetch a structure from the Protein Data Bank (PDB) using a PDB ID;",
        tags$br(),
        tags$strong("2.", style="margin-left: 15px;"),
        "Upload a PDB file from your computer.",
        tags$br(),
        "In both options, the structure is screened for non-standard protein or nucleic acid residues, such as water, ligands, and ions.",
        tags$br(),
        "By default, KVFinder-web removes all non-standard protein residues from the input. For example, if a target pocket contains a ligand, that ligand is automatically excluded before computing the cavity.",
        tags$br(),
        "However, in specific situations, you may want to evaluate a portion of a cavity that includes a ligand, water, or ions. In such cases, you can use the 'Include' option to incorporate the non-standard residue into the analysis."
      ),
      style = "text-align: justify; margin-top: 0px; margin-bottom: 0px; padding-top: 0px; padding-bottom: 0px; margin-right: 0.5rem;"
    )

  )

  return(input_card)
}
