#' Function that creates the boxes and buttons of the run mode in upload mode
#'
#' @param input shiny input
#' @param output shiny output
#' @param session
#'
#' @import shiny
#'
#' @export
#'

process_upload <- function(input, output, session) {
  # get nonstandard residues from the input PDB
  get_nonstand <<- report_nonstand(pdb_input = input$input_pdb$datapath)
  # if there is any nonstand residue in PDB...
  if (length(get_nonstand) > 0) {
    # always start by updating the radio button.
    # this is done because we need to update the run mode box to remove the radio button of the ligand mode if there's no ligand in the input PDB
    # so we need to always update to show all buttons
    updateRadioButtons(
      inputId = "run_mode",
      label = "Detect cavities in:",
      choices = c(
        "Whole structure (default)" = "mode_def",
        "Whole structure (customized)" = "mode_cust",
        "Around target molecule" = "lig_mode",
        "Around target residues" = "box_mode"
      )
    )

    # checkpoint to create the uiOuput of show_lig_name of ligmode
    updateSelectInput(
      inputId = "lig_name",
      label = "Ligand or molecule name:",
      choices = get_nonstand,
      selected = NULL
    )
    # create a check box to allow users to include some nonstandard residues
    output$checkbox_nostand1 <- renderUI({
      checkboxGroupInput(inputId = "select_nonstand1", label = "Non-standard residues found (select to consider them as part of the biomolecular surface in the cavity detection):", choices = get_nonstand, selected = TRUE)
    })
    # Note to guide the user in the choose
    output$note_text1 <- renderUI({
      tags$h6(
        strong("Note:"), 
        "By default, KVFinder-web removes all non-standard residues from the input file, which is usually the preferred choice. However, for specific cases where you want to include these residues as part of the biomolecular surface for cavity detection, select the residues below to include them. Otherwise, keep the checkbox unselected.",
        style = "text-align: justify;"
      )
    })
  } else {
    # Do not show any widgets related to nonstandard residues inclusion
    output$checkbox_nostand1 <- NULL
    output$note_text1 <- NULL
    # In case there is no ligand in the PDB, the ligand mode is removed from the run mode.
    updateRadioButtons(
      inputId = "run_mode",
      label = "Detect cavities in:",
      choices = c(
        "Whole structure (default)" = "mode_def",
        "Whole structure (customized)" = "mode_cust",
        "Around target residues" = "box_mode"
      )
    )
  }
}
