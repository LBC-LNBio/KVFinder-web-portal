#' Create an initial scene in NGL viewer
#' 
#' @param input shiny input
#' @param output shiny output
#' @param result_pdb_list a list returned by check results function
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page). 
#' @param scheme_color_list list of protein color schemes
#' 
#' @import shiny
#' @import NGLVieweR
#' @import colourpicker
#'
#' @export
#' 

create_init_scene <- function(input, output, result_pdb_list, is_pg2, scheme_color_list){
  #if in secondary page ("get latest results" page)
  if(is_pg2 == TRUE){
    structure <- "structure_pg2"
    selection_pdb <-"selection_pdb_pg2"
    select_cavity <- "select_cavity_pg2"
    show_interface <- "show_interface_pg2"
    protein_color <- "protein_color_pg2"
    protein_color_scheme <- "protein_color_scheme_pg2"
    cavity_color <- "cavity_color_pg2"
    protein_rep <- "protein_rep_pg2"
    bg_color <- "bg_color_pg2"
    snapshot_title <- "snapshot_title_pg2"
    snapshot <- "snapshot_pg2"
    interface_res <- "interface_res_pg2"
    fullscreen <- "fullscreen_pg2"
    fullscreen_title <- "fullscreen_title_pg2"
    #if in the main page
  } else{
    structure <- "structure"
    selection_pdb <- "selection_pdb"
    select_cavity <- "select_cavity"
    show_interface <- "show_interface"
    protein_color <- "protein_color"
    protein_color_scheme <- "protein_color_scheme"
    cavity_color <- "cavity_color"
    protein_rep <- "protein_rep"
    bg_color <- "bg_color"
    snapshot_title <- "snapshot_title"
    snapshot <- "snapshot"
    interface_res <- "interface_res"
    fullscreen <- "fullscreen"
    fullscreen_title <- "fullscreen_title"
    
  }
  
  #-------------------------------------------------------------------------------------------------------
  #Create structure viewer 
  #This initial scene is only created to start a structure Representation (invisible - except cavities) that will be updated and changes in view_create_work_scene 
  output[[structure]] <- renderNGLVieweR({
    #get input protein PDB with output cavities
    pdb_all <- paste(result_pdb_list$retrieve_input_pdb, result_pdb_list$result_pdb_cav,sep = "\n")
    #create initial scene
    NGLVieweR(pdb_all,format = "pdb") %>%
      #start protein with visible cartoon representation and name that representation as "protein_init_cartoon"
      addRepresentation("cartoon",
                        param = list(name = "protein_init_cartoon", colorScheme = "residueindex", visible = TRUE)
      ) %>%
      #start cavity with points
      addRepresentation("point", param = list(sele = paste(result_pdb_list$result_cav_names, collapse = " or "))
      ) %>%
      stageParameters(backgroundColor = "black") %>%
      setQuality("high") %>%
      setFocus(0)
  })
  
  #---------------------------------------------------------------------------------------------------------
  #create viewer buttons
  #select cavity button
  output[[selection_pdb]] <- renderUI({
    div(style = "font-size:12px;",
        selectInput(inputId = select_cavity, label = div(style = "font-size:12px", "Show cavity"), 
                    choices = c("All",result_pdb_list$result_cav_names)))})
  #show interface button
  output[[show_interface]] <- renderUI({
    div(style = "font-size:12px;",
        checkboxInput(inputId = interface_res, label = div(style = "font-size:12px;display:inline-block", "Show interface residues")))})
  #protein color scheme selector
  output[[protein_color_scheme]] <- renderUI({ div(style = "font-size:12px;",
                                                   selectInput(inputId = paste("input_",protein_color_scheme, sep = ""), label = div(style = "font-size:12px", "Protein color scheme"),
                                                               choices = names(scheme_color_list)))})
  #protein color selector
  output[[protein_color]] <- renderUI({ div(style = "font-size:12px;",
                                            colourpicker::colourInput(paste("input_",protein_color, sep = ""), 
                                                                      label = div(style = "font-size:12px", "Protein color"),
                                                                      value = "white",
                                                                      showColour = "background",
                                                                      palette = "limited"))})
  #cavity color selector
  output[[cavity_color]] <- renderUI({ div(style = "font-size:12px;",
                                           selectInput(inputId = paste("input_",cavity_color, sep = ""), label = div(style = "font-size:12px", "Cavity color"), 
                                                       choices = c( "white","red", "blue", "green","yellow")))})
  #protein representation selector
  output[[protein_rep]] <- renderUI({ div(style = "font-size:12px;",
                                          selectInput(inputId = paste("input_", protein_rep, sep = ""), label = div(style = "font-size:12px", "Protein representation"), 
                                                      choices = c("cartoon","point", "ball+stick", "line", "ribbon","spacefill", "surface")))})
  #background color selector
  output[[bg_color]] <- renderUI({ div(style = "font-size:12px;",
                                       selectInput(inputId = paste("input_", bg_color, sep = ""), label = div(style = "font-size:12px", "Background color"), 
                                                   choices = c( "black","white")))})
  #snapshot button
  output[[snapshot_title]] <-  renderUI({ div(style = "font-size:12px;font-weight: bold", "Snapshot")})
  output[[snapshot]] <- renderUI({ div(style = "font-size:12px;",
                                       actionButton(inputId = paste("input_", snapshot, sep = ""), label = "", 
                                                    width = 40, icon = icon("camera")))})
  #fullscreen button
  output[[fullscreen_title]] <-  renderUI({ div(style = "font-size:12px;font-weight: bold", "Fullscreen")})
  output[[fullscreen]] <- renderUI({ div(style = "font-size:12px;",
                                         actionButton(inputId = paste("input_", fullscreen, sep = ""), label = "", 
                                                      width = 40, icon = icon("fullscreen",lib = "glyphicon")))})
  #----------------------------------------------------------------------------------------------------------------
}