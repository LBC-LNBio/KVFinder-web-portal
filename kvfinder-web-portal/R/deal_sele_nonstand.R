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
#' 
#' @export
#'

deal_sele_nonstand <- function(input,pdb_input, nonstand_list, include_list, session = session) {
  tryCatch(
    { # test if the pdb_input is an appropriated PDB ID and if the read,pdb function can download successfully this pdb
      pdb <- read.pdb(pdb_input, multi=T)
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
