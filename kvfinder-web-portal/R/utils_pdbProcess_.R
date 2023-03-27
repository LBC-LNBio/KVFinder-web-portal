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
#' @export

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


#' Process PDB file according to the selected non-standard residues
#'
#' @description
#' Process PDB file according to the selected non-standard residues
#'
#' @param input
#' @param pdb_input Pdb path
#' @param nonstand_list List of non-standard residues
#' @param include_list List of non-standard residues that must be maintained in the PDB
#' @param session
#'
#' @import bio3d
#' @import shinyWidgets
#'
#' @examples
#' @export
#'

deal_sele_nonstand <- function(input,pdb_input, nonstand_list, include_list, session = session) {
  tryCatch(
    { # test if the pdb_input is an appropriated PDB ID and if the read,pdb function can download successfully this pdb
      pdb <- read.pdb(pdb_input, multi=T)
      print(dim(pdb$xyz)[1])
      print(include_list)
      if (is.null(include_list)) {
        
        # get nonstandard selected
        indx_s <- atom.select(pdb, resid = nonstand_list, inverse = TRUE)
        # subset pdb
        clean_pdb <- trim.pdb(pdb, indx_s)
        # create random number to name file
        rand <- sample(x = 1:100000, size = 1)
        outfile <- file.path(tempdir(), paste(rand, ".pdb", sep = ""))
        # write tmp
        if(dim(pdb$xyz)[1] > 1){ #case of multimodel, use the model selected by the user
          write.pdb(pdb = clean_pdb, file = outfile, xyz=clean_pdb$xyz[as.numeric(input$model_number),])
        } else{
          write.pdb(pdb = clean_pdb, file = outfile)
        } 
        return(outfile)
      } else {
        indx_s <- atom.select(pdb, resid = nonstand_list, inverse = TRUE)
        indx_i <- atom.select(pdb, resid = include_list)
        indx <- combine.select(indx_s, indx_i, operator = "OR")
        clean_pdb <- trim.pdb(pdb, indx)
        # create random number to name file
        rand <- sample(x = 1:100000, size = 1)
        outfile <- file.path(tempdir(), paste(rand, ".pdb", sep = ""))
        # write tmp
        if(dim(pdb$xyz)[1] > 1){#case of multimodel, use the model selected by the user
          print(input$model_number)
          print('multimodel')
          write.pdb(pdb = clean_pdb, file = outfile, xyz=clean_pdb$xyz[as.numeric(input$model_number),])
        } else{
          write.pdb(pdb = clean_pdb, file = outfile)
        } 
        return(outfile)
      }
    },
    error = function(e) {
      shinyWidgets::sendSweetAlert(session = session, title = "Oops!", text = "Please insert a valid PDB ID.", type = "error")
    }
  )
}


#' Get only target ligand PDB
#'
#' @description
#' Separate from protein/nucleic PDB the target ligand
#'
#' @param pdb_input Pdb path
#' @param ligand_name Name of the ligand
#'
#' @import bio3d
#'
#' @examples
#' @export
#'

get_ligand_pdb <- function(pdb_input, ligand_name) {
  pdb <- read.pdb(pdb_input)
  indx_l <- atom.select(pdb, resid = ligand_name)
  clean_pdb <- trim.pdb(pdb, indx_l)
  # create random number to name file
  rand <- sample(x = 1:100000, size = 1)
  outfile <- file.path(tempdir(), paste(rand, "lig.pdb", sep = ""))
  # write tmp
  write.pdb(pdb = clean_pdb, file = outfile)
  return(outfile)
}
