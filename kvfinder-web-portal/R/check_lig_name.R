#' Check if target ligand is in the PDB file
#'
#' @description
#' Check if target ligand is in the PDB file
#'
#' @param pdb_input Pdb path
#' @param target_ligand target ligand name
#'
#' @import bio3d
#'
#' @examples
#' @export
#'

check_lig_name <- function(pdb_input, target_ligand) {
  pdb <- read.pdb(pdb_input)
  if (target_ligand %in% pdb$atom$resid) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
