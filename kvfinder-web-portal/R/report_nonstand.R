#' Get non-standard protein/nucleic residues
#'
#' @description
#' Get non standard protein/nucleic residues from PDB
#'
#' @param pdb_input Pdb path
#' @param show_modal
#'
#' @import bio3d
#'
#' @examples
#' 
#' @export
#' 

report_nonstand <- function(pdb_input, show_modal) {
  if(missing(show_modal)){ #in some calls there's no need to inform the if want to use the show modal presented below for multi models
    show_modal = FALSE
  } else{
    show_modal = show_modal
  }
  pdb <- tryCatch(
    {
      read.pdb(pdb_input, multi = T)
    },
    error = function(err) {
      return(NA)
    }
  )
  if (class(pdb)[1] == "pdb") {
    # check multimodels
    if (class(pdb)[1] == "pdb" & dim(pdb$xyz)[1] > 1 & show_modal == TRUE) {
      #shinyWidgets::sendSweetAlert(title = "Oops!", text = "A multimodel structure was detected as input: Using only the first structure from the multimodel...", type = "warning")
      showModal(modalDialog(
        tags$h3('The input contains multiple models.'),
        tags$h5('Please select a single model below:'),
        selectInput('model_number', 'Model number',seq(1,dim(pdb$xyz)[1])),
        footer=tagList(
          modalButton('Select')
        )
      ))  
    }
    # get protein
    indx_p <- atom.select(pdb, string = "protein", inverse = TRUE)
    # get nucleic
    indx_n <- atom.select(pdb, string = "nucleic", inverse = TRUE)
    # combine them
    indx <- combine.select(indx_p, indx_n, operator = "AND")
    # subset pdb
    clean_pdb <- trim.pdb(pdb, indx)
    nonstand <- unique(clean_pdb$atom$resid)
    return(nonstand)
  } else {
    return(NA)
  }
}
