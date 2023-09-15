#' Function that creates the help page of the KVFinder server
#'
#' @import shiny
#'
#' @export
#'

kv_help <- function() {

  fluidPage(

    # Help topic
    tags$h2(
      strong("Help"),
      style = "text-align: center;"
    ),
    tags$br(),

    # Overview
    tags$h4(
      strong("Overview"),
      style = "text-align: center;"
    ),
    tags$br(),
    tags$p(
      "KVFinder-web is an open-source web-based application of an updated \ 
      version of ",
      tags$a(
        href = "https://github.com/LBC-LNBio/parKVFinder",
        "parKVFinder"
      ),
      "software (",
      tags$a(
        href = "https://github.com/LBC-LNBio/parKVFinder/releases/tag/v1.2.0",
        "v1.2.0"
      ),
      ") for cavity detection and characterization of any type of \ 
      biomolecular structure, including but not limited to proteins and \ 
      nucleic acids. KVFinder-web employs a geometric grid-and-sphere-based \ 
      method with a dual-probe system for efficient cavity detection. The \ 
      web-based application provides comprehensive characterizations, \ 
      including shape, volume, area, depth, constitutional, and hydropathy \ 
      informations. For a more detailed explanation, please refer to",
      tags$a(
        href = "https://doi.org/10.1186/1471-2105-15-197",
        "Oliveira et al. 2014"
      ),
      ", ",
      tags$a(
        href = "https://doi.org/10.1016/j.softx.2020.100606",
        "Guerra et al. 2020"
      ),
      ", ",
      tags$a(
        href = "https://doi.org/10.1186/s12859-021-04519-4",
        "Guerra et al. 2021"
      ),
      ", and ",
      tags$a(
        href = "https://doi.org/10.1093/nar/gkad324",
        "Guerra et al. 2023"
      ),
      ".",
      style = "text-align:justify"
    ),
    tags$hr(),

    # Detection parameters
    tags$h4(
      strong("Detection parameters"),
      style = "text-align: center;"
    ),
    tags$br(),

    tags$p(
      "To detect cavities in biomolecular structures, KVFinder-web uses the \ 
      following detection parameters:",
      style = "text-align:justify"
    ),
    tags$ul(
      tags$li(
        strong("Probe In (Å):"),
        " A smaller probe that defines the biomolecular surface by rolling \ 
        around the target biomolecule. Typically, this is set to the size of \ 
        a water molecule (1.4 Å).",
      ),
      tags$li(
        strong("Probe Out (Å):"),
        " A larger probe that defines inacessibility region, i.e., the cavity \ 
        and by rolling around the target biomolecule. Users can adjust the \ 
        size of the probe based on the characteristics of the target \ 
        structure.",
      ),
      tags$li(
        strong("Removal Distance (Å):"),
        " A length that is removed from the boundary between the cavity and \ 
        bulk (solvent) region.",
      ),
      tags$li(
        strong("Volume Cutoff (Å³):"),
        " A cavity volume filter to exclude cavities with smaller volumes \ 
        than this limit. These smaller cavities are typically not relevant \ 
        for function.",
      ),
      style = "text-align:justify"
    ),
    tags$p(
      "A schematic representation of cavity detection algorithm in \ 
      KVFinder-web is presented below. It shows the process of detecting \ 
      cavities within a biomolecular structure using probes and removal \ 
      distance to define the cavity boundaries. In panel (A), a biomolecular \ 
      structure X is inserted into a grid. In panel (B), Probe In (Pi) scans \ 
      the surface of the structure, by translating over the grid points \ 
      (orange). In panel (C), Probe Out (Po) scans the accessible points in \ 
      blue. In panel (D), the cavity points (light grey) are defined as the \ 
      difference between the probes' accessible points. The points not \ 
      reached by Pi (dark grey) define the Solvent Excluded Surface (SES). \ 
      In panel (E), a removal distance routine is applied to remove cavity \ 
      points within a given distance from the cavity-bulk boundary (yellow \ 
      line).",
      style = "text-align:justify",
    ),
    tags$p(
      tags$img(
        src = "www/kvfinder-web-schema.png",
        style = "width: 100%; max-width: 800px;"
      ),
      style = "display: flex; justify-content: center;"
    ),
    tags$p(
      "Source:",
      tags$a(
        href = "https://doi.org/10.1021/acs.jcim.3c00328",
        "Guerra et al. (2023)"
      ),
      ". Copyright 2023 American Chemical Society.",
      style = "text-align: center"
    ),
    tags$hr(),

    # Impact of parameters on detection
    tags$h4(
      strong("Impact of parameters on cavity detection"),
      style = "text-align: center;"
    ),
    tags$br(),
    tags$p(
      "Two important parameters for cavity detection in KVFinder-web are ",
      tags$strong("Probe Out"),
      " and ",
      tags$strong("Removal Distance"),
      ", which directly affect execution time.",
      style = "text-align:justify",
    ),
    tags$ul(
      tags$li(
        tags$strong("Probe Out (Å):"),
        " This larger probe defines the boundary between the cavity and \ 
        the bulk (solvent) by systematically translating in a Cartesian \ 
        grid around the target biomolecule. Larger Probe Out sizes reduce \ 
        the degree of accessibility of the molecular surface, leading to \ 
        longer calculation times. "
      ),
      tags$li(
        tags$strong("Removal Distance (Å):"),
        " This parameter removes cavity points within a specified distance \ 
        from the defined cavity-bulk boundary. Reducing the Removal Distance \ 
        removes fewer points from the boundary, aiding in the segregation of \ 
        sub-pockets and the detection of superficial cavities. Additionally, \ 
        larger Removal Distance values lead to longer calculation times."
      ),
      style = "text-align:justify",
    ),
    tags$p(
      "In addition to these parameters, KVFinder-web's execution time \ 
      increases linearly with the number of atoms in the target biomolecule \ 
      within the 3D grid. However, users can control the number of atoms by \ 
      defining a custom search space around the ligand/molecule or residues, \ 
      which can reduce execution time.",
      style = "text-align:justify",
    ),
    tags$hr(),

    # Cavity naming convention
    tags$h4(
      strong("Cavity naming convention"),
      style = "text-align: center;"
    ),
    tags$br(),
    tags$p(
      "Cavities in KVFinder suite (parKVFinder, pyKVFinder, and KVFinder-web) \ 
      are named based on integer labels assigned to each cavity in the 3D \ 
      grid. The first cavity identified is labeled as KAA, the second as KAB, \ 
      the third as KAC, and so on. These labels are assigned using a DFS \ 
      clustering algorithm, which identifies cavities in the order they are \ 
      found in the 3D grid. Specific labels used in the algorithm include:",
      style = "text-align:justify",
    ),
    tags$ul(
      tags$li(
        tags$strong("-1:"),
        " bulk (solvent);"
      ),
      tags$li(
        tags$strong("0:"),
        " biomolecule;"
      ),
      tags$li(
        tags$strong("1:"),
        " empty space (cavities that do not reach the volume cutoff);"
      ),
      tags$li(
        tags$strong(">1:"),
        " cavities."
      ),
      style = "text-align:justify",
    ),
    tags$hr(),

    # TOML-formatted results file
    tags$h4(
      strong("TOML-formatted results file"),
      style = "text-align: center;"
    ),
    tags$br(),
    tags$p(
      
    ),
    tags$hr(),

    # Depth characterization
    tags$h4(
      strong("Depth characterization"),
      style = "text-align: center;"
    ),
    tags$br(),
    tags$p(
      "Depth characterization assesses the degree of burial of the binding \ 
      site, with the largest and deepest cavity often corresponding to the \ 
      active site in an enzymatic protein. This information can help identify \ 
      the active site on the molecular surface.",
      style = "text-align:justify",
    ),
    tags$p(
      "A schematic representation of the depth characterization process is \ 
      shown below, illustrating how it calculates the depth of each cavity \ 
      point based on its proximity to the boundary points. A spatial filter \ 
      is used to evaluate whether a cavity point (in black) is a direct \ 
      neighbor (red point) of a bulk point, which assigns it as a boundary \ 
      point (as shown in panel A of the schematic). The distance between the \ 
      cavity point (in black) and the boundary points (in red) is then \ 
      calculated (as shown in panel B of the schematic), and the shortest \ 
      distance (indicated by the blue line) represents the depth of the \ 
      cavity point. By calculating the depth of all cavity points, the \ 
      maximum and average depths can be determined for each detected cavity.",
      style = "text-align:justify",
    ),
    tags$p(
      tags$img(
        src = "www/depth-characterization-scheme.png",
        style = "width: 100%; max-width: 600px;"
      ),
      style = "display: flex; justify-content: center;"
    ),
    tags$p(
      "Source:",
      tags$a(
        href = "https://doi.org/10.1016/j.softx.2020.100606",
        "Guerra et al. (2021)"
      ),
      ". License:",
      tags$a(
        href="https://creativecommons.org/licenses/by/4.0/",
        "CC BY 4.0"
      ),
      ".",
      style = "text-align: center"
    ),
    tags$hr(),

    # Hydropathy characterization
    tags$h4(
      strong("Hydropathy characterization"),
      style = "text-align: center;"
    ),
    tags$br(),
    tags$p(
      "Hydropathy characterization provides valuable insights into the water \ 
      attractiveness and types of interactions at the interface of the \ 
      binding site.",
      style = "text-align:justify"
    ),
    tags$p(
      "A schematic represention of hydropathy characterization is shown \ 
      below. The ",
      tags$a(
        href = "https://doi.org/10.1073/pnas.81.1.140",
        "Eisenberg & Weiss"
      ),
      " hydrophobicity scale ranges from -1.42 (highly hydrophobic) to 2.6 \ 
      (highly hydrophilic), projecting the value of the amino acid nearest \ 
      to a target surface point. Panel A displays the hydrophobicity of each \ 
      amino acid. The distances between a surface point (black) and the atoms \ 
      (carbon: green; oxygen: red; nitrogen: blue; sulfur: yellow) of the \ 
      amino acids (methionine: left; valine: right) are calculated, and the \ 
      residue of the atom with the shortest distance (indicated by the red \ 
      line) maps its hydrophobicity value onto it (as shown in panel B).",
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/hydropathy-characterization-scheme.png",
        style = "width: 100%; max-width: 800px;"
      ),
      style = "display: flex; justify-content: center;"
    ),
    tags$p(
      "Source:",
      tags$a(
        href = "https://doi.org/10.1016/j.softx.2020.100606",
        "Guerra et al. (2021)"
      ),
      ". License:",
      tags$a(
        href="https://creativecommons.org/licenses/by/4.0/",
        "CC BY 4.0"
      ),
      ".",
      style = "text-align: center"
    ),
    tags$hr(),

    # Requirements and limitations
    tags$h4(
      strong("Requirements and limitations"),
      style = "text-align: center;"
    ),
    tags$br(),
    tags$p(
      "The KVFinder-web service has a Job timeout of 30 minutes (the maximum \ 
      time that an accepted job could run on the server). Completed jobs will \ 
      be available on the web service up to 1 day after completion. The \ 
      maximum payload (maximum size of the JSON) of the data sent to the \ 
      KVFinder-web service is 1 MB.",
      style = "text-align:justify"
    ),
    tags$p(
      "Additionally, the KVFinder-web service has some limitations, compared \ 
      to a local installation of parKVFinder, including:",
      style = "text-align:justify"
    ),
    tags$ul(
      tags$li(
        tags$strong("Probe In"),
        " size must not exceed 5 Å to prevent unnecessary time-consuming jobs;",
      ),
      tags$li(
        tags$strong("Probe Out"),
        " size must not exceed 50 Å to prevent unnecessary time-consuming \ 
        jobs;",
      ),
      tags$li(
        tags$strong("Removal Distance"),
        " must not exceed 10 Å to prevent unnecessary time-consuming jobs;",
      ),
      tags$li(
        "The ",
        tags$strong("grid spacing"),
        " is pre-set to 0.6 Å to prevent unnecessary time-consuming jobs;",
      ),
      tags$li(
        "Cavity representation will always be ",
        tags$strong("filtered"),
        " (this reduces the space consumed by cavity files on the web \ 
        service and conserves resources for NGL visualization).",
      ),
      style = "text-align: jusitfy;"
    ),
    tags$p(
      "This website is free and open to all users, and there is no login \ 
      requirement.",
      style = "text-align: justify;"
    ),
    tags$hr()
  )
}
