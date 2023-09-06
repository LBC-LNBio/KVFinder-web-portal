#' Check if residues name are in the PDB file
#'
#' @description
#' Check if residues name are in the PDB file
#'
#' @param pdb_input Pdb path
#' @param target_residues list of residues name
#'
#' @import bio3d
#'
#' @examples
#' 
#' @export
#'

check_residues_name <- function(pdb_input, target_residues) {
  pdb <- read.pdb(pdb_input)
  resno <- unique(unlist(lapply(strsplit(target_residues, ";")[[1]], function(x) strsplit(x, "_")[[1]][1])))
  chain <- unique(unlist(lapply(strsplit(target_residues, ";")[[1]], function(x) strsplit(x, "_")[[1]][2])))
  if (TRUE %in% (pdb$atom$resno %in% resno & pdb$atom$chain %in% chain)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
