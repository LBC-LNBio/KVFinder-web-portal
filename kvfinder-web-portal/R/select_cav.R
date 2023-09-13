#' Select cavities to show
#'
#' @param input shiny input
#' @param output shiny output
#' @param result_pdb_list a list returned by check function
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page).
#' @param cav_rep_list
#' @import shiny
#' @import NGLVieweR
#'
#' @export
#'


select_cav <- function(input, output, result_pdb_list, is_pg2, cav_rep_list) {
  if (is_pg2 == TRUE) {
    select_cavity <- "select_cavity_pg2"
    structure <- "structure_pg2"
    interface_res <- "interface_res_pg2"
  } else {
    select_cavity <- "select_cavity"
    structure <- "structure"
    interface_res <- "interface_res"
  }
  # if click to select cavity...
  if (input[[select_cavity]] == "All") { # show all cavities
   if(!is.null(cav_rep_list)){
     #to update interface res
     res <- paste(unlist(lapply(result_pdb_list$result_toml$RESIDUES, function(x) lapply(x, function(y) paste(y[1], y[2], sep = ":")))), collapse = " or ")
     NGLVieweR_proxy(structure) %>%
       updateSelection("sel1", sele = res)
     
     if(isTRUE(input$input_cavity_deep) | isTRUE(input$input_cavity_deep_pg2)){
       NGLVieweR_proxy(structure) %>%
         updateSelection(tail(cav_rep_list, n = 1), sele = paste(result_pdb_list$result_cav_names, collapse = " or ")) %>%
         #updateSelection("deepth", sele = paste(result_pdb_list$result_cav_names, collapse = " or "))
         removeSelection(name = "deepth") %>%
         addSelection(tail(cav_rep_list, n = 1),
                      param =
                        list(
                          name = "deepth", # now the created selection is named "sel3"
                          sele = paste(result_pdb_list$result_cav_names, collapse = " or "),
                          colorScheme = 'bfactor',
                          colorScale = 'rainbow',
                          colorReverse = TRUE,
                          surfaceType = 'vws',
                          probeRadius = 0.3,
                          #colorDomain = c(0.0, max(unlist(result_pdb_list$result_toml$MAX_DEPTH)))
                          colorDomain = c(0.0, max(unlist(result_pdb_list$result_toml$MAX_DEPTH))) #I had to invert the domain 
                          #colorScheme = scheme_color_list[[tail(protein_col_scheme_list, n = 1)]]
                        )
         )
       
     } else if(isTRUE(input$input_cavity_hyd) | isTRUE(input$input_cavity_hyd_pg2)){
       NGLVieweR_proxy(structure) %>%
      updateSelection(tail(cav_rep_list, n = 1), sele = paste(result_pdb_list$result_cav_names, collapse = " or ")) %>%
       #updateSelection("hyd", sele = paste(result_pdb_list$result_cav_names, collapse = " or "))
       removeSelection(name = "hyd") %>%
       addSelection(tail(cav_rep_list, n = 1),
                      param =
                        list(
                          name = "hyd", # now the created selection is named "sel3"
                          sele = paste(result_pdb_list$result_cav_names, collapse = " or "),
                          colorScheme = 'occupancy',
                          colorScale = c('blue', 'white', 'yellow'),
                          colorReverse = TRUE,
                          surfaceType = 'vws',
                          probeRadius = 0.3,
                          colorDomain = c(-1.42, 2.6)
                          #colorScheme = scheme_color_list[[tail(protein_col_scheme_list, n = 1)]]
                        )
         )   
     } else{
       NGLVieweR_proxy(structure) %>%
         updateSelection(tail(cav_rep_list, n = 1), sele = paste(result_pdb_list$result_cav_names, collapse = " or "))
     }
   }
     
  } else { # show one cavity to show and zoom it
    #to update interface
    res <- paste(unlist(lapply(result_pdb_list$result_toml$RESIDUES[[input[[select_cavity]]]], function(x) paste(x[1], x[2], sep = ":"))), collapse = " or ")
    NGLVieweR_proxy(structure) %>%
      updateSelection("sel1", sele = res)
    if(isTRUE(input$input_cavity_deep) | isTRUE(input$input_cavity_deep_pg2)){
      NGLVieweR_proxy(structure) %>%
        updateSelection(tail(cav_rep_list, n = 1), sele = paste(input[[select_cavity]]," and (not ",paste(result_pdb_list$result_cav_names[!result_pdb_list$result_cav_names == input[[select_cavity]]], collapse = " or "),')', sep="")) %>%
        #updateSelection("deepth", sele = input[[select_cavity]]) %>% #update selection is someway change the scale and inverting it to the default
        removeSelection(name = "deepth") %>%
        addSelection(tail(cav_rep_list, n = 1),
                     param =
                       list(
                         name = "deepth", # now the created selection is named "sel3"
                         sele = input[[select_cavity]],
                         colorScheme = 'bfactor',
                         colorScale = 'rainbow',
                         colorReverse = TRUE,
                         surfaceType = 'vws',
                         probeRadius = 0.3,
                         colorDomain = c( 0.0, max(unlist(result_pdb_list$result_toml$MAX_DEPTH)))
                         #colorScheme = scheme_color_list[[tail(protein_col_scheme_list, n = 1)]]
                       )
        ) %>%
        updateZoomMove(input[[select_cavity]], input[[select_cavity]], 2000, -20)
    } else if(isTRUE(input$input_cavity_hyd) | isTRUE(input$input_cavity_hyd_pg2)){
      NGLVieweR_proxy(structure) %>%
        updateSelection(tail(cav_rep_list, n = 1), sele = paste(input[[select_cavity]]," and (not ",paste(result_pdb_list$result_cav_names[!result_pdb_list$result_cav_names == input[[select_cavity]]], collapse = " or "),')', sep="")) %>%
        #updateSelection("hyd", sele = input[[select_cavity]]) %>%
        removeSelection(name = "hyd") %>%
        addSelection(tail(cav_rep_list, n = 1),
                     param =
                       list(
                         name = "hyd", # now the created selection is named "sel3"
                         sele = input[[select_cavity]],
                         colorScheme = 'occupancy',
                         colorScale = c('blue', 'white', 'yellow'),
                         colorReverse = TRUE,
                         surfaceType = 'vws',
                         probeRadius = 0.3,
                         colorDomain = c(-1.42, 2.6)
                         #colorScheme = scheme_color_list[[tail(protein_col_scheme_list, n = 1)]]
                       )
        ) %>%
        updateZoomMove(input[[select_cavity]], input[[select_cavity]], 2000, -20)
    } else{
      if(tail(cav_rep_list, n = 1) == 'point'){
        NGLVieweR_proxy(structure) %>%
          updateSelection("point", sele = input[[select_cavity]]) %>%
          updateZoomMove(input[[select_cavity]], input[[select_cavity]], 2000, -20)
      }
      if(tail(cav_rep_list, n = 1) == 'surface'){
        NGLVieweR_proxy(structure) %>%
          updateSelection("surface", sele = input[[select_cavity]]) %>%
          updateZoomMove(input[[select_cavity]], input[[select_cavity]], 2000, -20)
      }
    }
  }
}
