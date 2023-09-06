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
#' 
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
