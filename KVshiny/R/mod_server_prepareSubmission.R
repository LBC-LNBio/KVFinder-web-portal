#' Function that creates a list containing the parameters to KVFinder server submission. It is called in mod_server_submitJob module. 
#' 
#' @import shiny
#' @import readr
#' 
#' @param pdb_path pdb path.
#' @param ligand_path ligand path. 
#' @param whole_protein_mode logical. True if the run mode use the entire protein.  
#' @param ligand_mode logical. True if the ligand mode is chosen. 
#' @param box_mode logical. True if the box mode is chosen. 
#' @param box_residues list of residues used in box mode. 
#' @param probe_in probe in value.
#' @param probe_out probe out value.
#' @param volume_cutoff cutoff volume value. 
#' @param removal_distance removal distance value
#' @param padding padding value 
#' @param lig_cutoff cutoff ligand value
#' 
#' @export
#' 

submit_prepare <- function(pdb_path, ligand_path, whole_protein_mode,ligand_mode, box_mode, box_residues, probe_in, probe_out, volume_cutoff, removal_distance, padding, lig_cutoff){
  #get pdb path and read file
  pdb = read_file(pdb_path)
  #create named lists with parameters
  list_modes = list(whole_protein_mode = whole_protein_mode, 
                    box_mode = box_mode,  
                    resolution_mode = "Low",
                    surface_mode = TRUE,
                    kvp_mode = FALSE,
                    ligand_mode = ligand_mode)
  list_stepSize = list(step_size = 0.0)
  list_probes = list(probe_in = probe_in,
                     probe_out = probe_out)
  list_cutoffs = list(volume_cutoff = volume_cutoff,
                      ligand_cutoff = 5.0,
                      removal_distance = removal_distance)
  list_visiblebox = list(p1 = list(x = 0.00, y= 0.00, z = 0.00),  
                         p2 = list(x = 0.00, y= 0.00, z = 0.00), 
                         p3 = list(x = 0.00, y= 0.00, z = 0.00), 
                         p4 = list(x = 0.00, y= 0.00, z = 0.00)) 
  list_internalbox = list(p1 = list(x = -4.00, y= -4.00, z = -4.00),  
                          p2 = list(x = 4.00, y= -4.00, z = -4.00),
                          p3 = list(x = -4.00, y= 4.00, z = -4.00),
                          p4 = list(x = -4.00, y= -4.00, z = 4.00))
  list_settings = list(modes = list_modes, 
                       step_size = list_stepSize, 
                       probes = list_probes, 
                       cutoffs = list_cutoffs, 
                       visiblebox = list_visiblebox, 
                       internalbox = list_internalbox)
  #combine the lists in each mode, with additional specific parameters when appropriated
  if(ligand_mode == TRUE){ #ligand mode 
    pdb_ligand <- read_file(ligand_path)
    list_cutoffs$ligand_cutoff <- lig_cutoff
    list_settings = list(modes = list_modes, 
                         step_size = list_stepSize, 
                         probes = list_probes, 
                         cutoffs = list_cutoffs, 
                         visiblebox = list_visiblebox, 
                         internalbox = list_internalbox)
    list_input <- list(pdb = pdb, pdb_ligand = pdb_ligand, settings= list_settings)
    return(list_input)
  } else if(box_mode == TRUE){ #box mode
    coord_list <- get_coord_box_mode(pdb_input = pdb_path, box_residues = box_residues) 
    if(!is.null(padding)){
      coord_list$xmin <- coord_list$xmin - padding
      coord_list$ymin <- coord_list$ymin - padding
      coord_list$zmin <- coord_list$zmin - padding
      coord_list$xmax <- coord_list$xmax + padding
      coord_list$ymax <- coord_list$ymax + padding
      coord_list$zmax <- coord_list$zmax + padding
    }
    list_visiblebox <- list(p1 = list(x = coord_list$xmin, y= coord_list$ymin, z = coord_list$zmin),  
                            p2 = list(x = coord_list$xmax, y= coord_list$ymin, z = coord_list$zmin),  
                            p3 = list(x = coord_list$xmin, y= coord_list$ymax, z = coord_list$zmin), 
                            p4 = list(x = coord_list$xmin, y= coord_list$ymin, z = coord_list$zmax)) 
    list_internalbox <- list(p1 = list(x = coord_list$xmin - probe_out, y= coord_list$ymin - probe_out, z = coord_list$zmin - probe_out), 
                             p2 = list(x = coord_list$xmax + probe_out, y= coord_list$ymin - probe_out, z =  coord_list$zmin - probe_out),  
                             p3 = list(x = coord_list$xmin - probe_out, y= coord_list$ymax + probe_out, z = coord_list$zmin - probe_out),
                             p4 = list(x = coord_list$xmin - probe_out, y= coord_list$ymin - probe_out, z = coord_list$zmax + probe_out))
    list_settings = list(modes = list_modes, 
                         step_size = list_stepSize, 
                         probes = list_probes, 
                         cutoffs = list_cutoffs, 
                         visiblebox = list_visiblebox, 
                         internalbox = list_internalbox)
    list_input <- list(pdb = pdb, settings= list_settings)
    return(list_input)
  } else{
    list_input <- list(pdb = pdb, settings= list_settings)
    return(list_input)
  }
}