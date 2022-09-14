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


select_cav <- function(input, output, result_pdb_list, is_pg2) {
  if (is_pg2 == TRUE) {
    select_cavity <- "select_cavity_pg2"
    structure <- "structure_pg2"
    interface_res <- "interface_res_pg2"
  } else {
    select_cavity <- "select_cavity"
    structure <- "structure"
    interface_res <- "interface_res"
  }
  print(input[[select_cavity]])
  # if click to select cavity...
  if (input[[select_cavity]] == "All") { # show all cavities
    NGLVieweR_proxy(structure) %>%
      updateSelection("point", sele = paste(result_pdb_list$result_cav_names, collapse = " or "))

    # Update to show interface results
    observeEvent(input[[interface_res]],
      {
        print("interfaceAll")

        if (input[[interface_res]] == TRUE & input[[select_cavity]] == "All") {
          # print(lapply(result_pdb_list$result_toml$RESIDUES, function(x) paste(x[1], x[2], sep = ":")))
          res <- paste(unlist(lapply(result_pdb_list$result_toml$RESIDUES, function(x) lapply(x, function(y) paste(y[1], y[2], sep = ":")))), collapse = " or ")
          # res <- paste(unlist(lapply(result_pdb_list$result_toml$RESIDUES[[input[[select_cavity]]]], function(x) paste(x[1], x[2], sep = ":"))), collapse = " or ")
          # print(res)
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
      },
      ignoreInit = TRUE
    )
  } else { # show one cavity to show and zoom it
    NGLVieweR_proxy(structure) %>%
      updateSelection("point", sele = input[[select_cavity]]) %>%
      updateZoomMove(input[[select_cavity]], input[[select_cavity]], 2000, -20)

    # Update to show interface results
    observeEvent(input[[interface_res]],
      {
        print("interfaceSpec")
        if (input[[interface_res]] == TRUE & input[[select_cavity]] != "All") {
          res <- paste(unlist(lapply(result_pdb_list$result_toml$RESIDUES[[input[[select_cavity]]]], function(x) paste(x[1], x[2], sep = ":"))), collapse = " or ")
          print(res)
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
      },
      ignoreInit = TRUE
    )
  }
}
