#' Create radio buttons of the run mode in main Run KVFinder page 
#' 
#' @import shiny
#' @import bs4Dash
#' 
#' @export

choose_input <- function(){
  
  input_card <- bs4Card(
                  title = "Step 2. Choose input",
                  id = "run_mode_box",
                  collapsible = TRUE,
                  collapsed = TRUE,
                  closable = FALSE,
                  solidHeader = TRUE,
                  elevation = 2,
                  headerBorder = TRUE,
                  width = 9,
                  fluidRow(
                    column(4, radioButtons("input_type", 
                                           "Type of input:",
                                           c("Upload PDB file" = "pdb_from_file",
                                             "Fetch from PDB" = "pdb_from_id"))),
                    column(8, conditionalPanel( condition = "input.input_type == 'pdb_from_file'",
                                                fileInput(inputId = "input_pdb",
                                                          label = "Upload PDB file",
                                                          accept = ".pdb",
                                                          width = 250 ),
                                                uiOutput("note_text1"),
                                                uiOutput("checkbox_nostand1",width = 800), 
                                                uiOutput("ask_preprocess_include1"),
                                                uiOutput("preprocess_include1")
                    ),
                    conditionalPanel( condition = "input.input_type == 'pdb_from_id'",
                                      fixedRow(
                                        column(3, 
                                               textInput(inputId = "pdb_id",
                                                         label = "PDB ID:",
                                                         placeholder = "ex: 1PRG",
                                                         width = 100)),
                                        column(1, div( style = "margin-top: 27px;"),
                                               actionButton(inputId = "send_pdb_id", 
                                                            label = "Load",
                                                            icon = icon("share-square"),
                                                            width = 90
                                               ))),
                                      uiOutput("note_text2"),
                                      uiOutput("checkbox_nostand2",width = 800),
                                      uiOutput("ask_preprocess_include2"),
                                      uiOutput("preprocess_include2"))
                    )),
                  
                  sidebar = boxSidebar(
                    id = "input_pdb_helpbar",
                    icon = icon("info"),
                    p("The cavity detection can be performed by uploading a PDB file from your computer or by fetching the Protein Data Bank using a PDB ID."),
                    p("In both cases the input is checked for non-standard protein or nucleic residues, for example water (HOH), ligands and ions molecules."),
                    p("By befault, kVFinder remove all non-standard protein or residues from the input. For instance, if a target pocket is occupied by a ligand, that ligand is removed before to compute the cavity."),
                    p("In specific situations, users may be interested in evaluate a portion of a cavity that is occupied by a ligand, water or a ions. In this case, users can use Include option to include the non-standard residue in the analysis."))) 
  
  return(input_card)
}