#' Create initial scene in NGL viewer
#' 
#' @param input shiny input
#' @param output shiny output
#' @param result_pdb_list a list returned by check function
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page). 
#' 
#' @import shiny
#' @import NGLVieweR
#'
#' @export
#' 

create_init_scene <- function(input, output, result_pdb_list, is_pg2){
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
    
    
  }
  #-------------------------------------------------------------------------------------------------------
  #Create structure view 
  #This initial scene is only created to start a structure Representation (invisible - except cavities) that will be updated and changes in view_create_work_scene 
  output[[structure]] <- renderNGLVieweR({
  pdb_all <- paste(result_pdb_list$retrieve_input_pdb, result_pdb_list$result_pdb_cav,sep = "\n")
  
  NGLVieweR(pdb_all,format = "pdb") %>%
    addRepresentation("cartoon",
                      param = list(name = "protein_init_cartoon", colorScheme = "residueindex", visible = TRUE)
    ) %>%
    addRepresentation("point", param = list(sele = paste(result_pdb_list$result_cav_names, collapse = " or "))
    ) %>%
    stageParameters(backgroundColor = "black") %>%
    setQuality("high") %>%
    setFocus(0)
  })
  #---------------------------------------------------------------------------------------------------------
  #create view buttons
  output[[selection_pdb]] <- renderUI({
    div(style = "font-size:12px;",
        selectInput(inputId = select_cavity, label = div(style = "font-size:12px", "Show cavity"), 
                    choices = c("All",result_pdb_list$result_cav_names)))})
  

    output[[show_interface]] <- renderUI({
      div(style = "font-size:12px;",
          checkboxInput(inputId = interface_res, label = div(style = "font-size:12px;display:inline-block", "Show interface residues")))})
    

  
  output[[protein_color_scheme]] <- renderUI({ div(style = "font-size:12px;",
                                         selectInput(inputId = paste("input_",protein_color_scheme, sep = ""), label = div(style = "font-size:12px", "Protein color scheme"), 
                                                     choices = c("residueindex","chainid", "hydrophobicity", "sstruc", "uniform")))})
  output[[protein_color]] <- renderUI({ div(style = "font-size:12px;",
                                           selectInput(inputId = paste("input_",protein_color, sep = ""), label = div(style = "font-size:12px", "Protein color"), 
                                                       choices = c("","white", "red", "blue", "green","yellow")))})
  
  output[[cavity_color]] <- renderUI({ div(style = "font-size:12px;",
                                        selectInput(inputId = paste("input_",cavity_color, sep = ""), label = div(style = "font-size:12px", "Cavity color"), 
                                                    choices = c( "white","red", "blue", "green","yellow")))})
  
  output[[protein_rep]] <- renderUI({ div(style = "font-size:12px;",
                                       selectInput(inputId = paste("input_", protein_rep, sep = ""), label = div(style = "font-size:12px", "Protein representation"), 
                                                   choices = c("cartoon","point", "ball+stick", "line", "ribbon","spacefill", "surface")))})
  
  output[[bg_color]] <- renderUI({ div(style = "font-size:12px;",
                                    selectInput(inputId = paste("input_", bg_color, sep = ""), label = div(style = "font-size:12px", "Background color"), 
                                                choices = c( "black","white")))})
  output[[snapshot_title]] <-  renderUI({ div(style = "font-size:12px;font-weight: bold", "Take a snapshot")})
  
  output[[snapshot]] <- renderUI({ div(style = "font-size:12px;",
                                    actionButton(inputId = paste("input_", snapshot, sep = ""), label = "", 
                                                 width = 40, icon = icon("camera")))})
  #----------------------------------------------------------------------------------------------------------------
}