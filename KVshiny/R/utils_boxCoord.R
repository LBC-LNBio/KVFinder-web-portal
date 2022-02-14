#' Get box coordinates in box mode 
#'
#' @description
#' Get box coordinates in box mode 
#'
#' @param pdb_input Pdb path 
#' @param box_residues List of target residues
#' 
#' @import bio3d
#' 
#' @examples 
#'
#' @export
#' 

get_coord_box_mode <- function(pdb_input, box_residues){
  pdb <- read.pdb(pdb_input)
  #process box residues 
  resno <- unique(unlist(lapply(strsplit(box_residues, ";")[[1]], function(x) strsplit(x, "_")[[1]][1])))
  chain <- unique(unlist(lapply(strsplit(box_residues, ";")[[1]], function(x) strsplit(x, "_")[[1]][2])))
  #subset pdb
  sub_pdb <- pdb$atom[pdb$atom$resno %in% resno & pdb$atom$chain %in% chain,]
  coord_list <- list(
    xmin = min(sub_pdb$x), 
    ymin = min(sub_pdb$y),
    zmin = min(sub_pdb$z),
    xmax = max(sub_pdb$x),
    ymax = max(sub_pdb$y),
    zmax = max(sub_pdb$z)
  )
  return(coord_list)
}