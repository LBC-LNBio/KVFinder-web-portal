#' Select cavities to show
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


interface_cav <- function(input, output, result_pdb_list, is_pg2) {
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
    if (input[[interface_res]] == TRUE & input[[select_cavity]] == "All") {
      res <- paste(unlist(lapply(result_pdb_list$result_toml$RESIDUES, function(x) lapply(x, function(y) paste(y[1], y[2], sep = ":")))), collapse = " or ")
      # res <- paste(unlist(lapply(result_pdb_list$result_toml$RESIDUES[[input[[select_cavity]]]], function(x) paste(x[1], x[2], sep = ":"))), collapse = " or ")
      NGLVieweR_proxy(structure) %>%
        # updateSelection("point", sele = paste(unlist(lapply(result_toml$RESIDUES[[input$select_cav]], function(x) x[1])), collapse = " or "))
        addSelection("ball+stick",
                    param =
                      list(
                        name = "sel1",
                        sele = res
                      )
        )
    } else {
      NGLVieweR_proxy(structure) %>%
        # updateSelection("point", sele = paste(unlist(lapply(result_toml$RESIDUES[[input$select_cav]], function(x) x[1])), collapse = " or "))
        removeSelection("sel1")
    }

  } 
  else { # show one cavity to show and zoom 
    if (input[[interface_res]] == TRUE & input[[select_cavity]] != "All") {
      res <- paste(unlist(lapply(result_pdb_list$result_toml$RESIDUES[[input[[select_cavity]]]], function(x) paste(x[1], x[2], sep = ":"))), collapse = " or ")
      NGLVieweR_proxy(structure) %>%
        # updateSelection("point", sele = paste(unlist(lapply(result_toml$RESIDUES[[input$select_cav]], function(x) x[1])), collapse = " or "))
        addSelection("ball+stick",
                    param =
                      list(
                        name = "sel1",
                        sele = res
                      )
        )
    } else {
      NGLVieweR_proxy(structure) %>%
        # updateSelection("point", sele = paste(unlist(lapply(result_toml$RESIDUES[[input$select_cav]], function(x) x[1])), collapse = " or "))
        removeSelection("sel1")
    }
  }
}
