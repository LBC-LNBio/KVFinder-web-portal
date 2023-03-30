#' Function that creates the help page of the KVFinder server
#'
#' @import shiny
#' @export
#'


kv_help <- function() {
  fluidPage(
    # Help topic
    fluidRow(
      column(12, align = "center", tags$h3(strong("KVFinder-web help page")))
    ),

    tags$br(),

    ## Overview description
    fluidRow(
      column(12, align = "center", tags$h5(strong("Overview"))),
      tags$p(
        "KVFinder-web is an open-source web-based application of an updated version of ",
        tags$a(
          href = "https://github.com/LBC-LNBio/parKVFinder",
          "parKVFinder"
        ),
        " software (v1.2.0) for cavity detection and characterization of any type of biomolecular structure, including but not limited to proteins and nucleic acids. KVFinder-web uses a geometrical grid-and-sphere based method with a dual-probe system to efficiently detect cavities. The web-based application also provides a comprehensive characterization that includes spatial, depth, constitutional, and hydropathy information. For a more detailed explanation, please refer",
        tags$a(
          href = "https://doi.org/10.1186/1471-2105-15-197",
          "Oliveira et al. 2014"
        ),
        ", ",
        tags$a(
          href = "https://doi.org/10.1016/j.softx.2020.100606",
          "Guerra et al. 2020"
        ),
        "and ",
        tags$a(
          href = "https://doi.org/10.1186/s12859-021-04519-4",
          "Guerra et al. 2021"
        ),
        ".",
        style = "text-align:justify"
      ),
    ),

    tags$br(),

    ## Detection parameters
    fluidRow(
      column(12, align = "center", tags$h5(strong("Detection parameters")))
    ),

    ### Probes
    fluidRow(
      tags$p("To detect cavities in biomolecular structures, KVFinder-web uses the following detection parameters:"),
      tags$ul(
        tags$li(strong("Probe In (Å):"), "A smaller probe that rolls around the target biomolecule and defines its surface. Typically, this is set to the size of a water molecule (1.4 Å).", style = "text-align:justify",),
        tags$li(strong("Probe Out (Å):"), "A larger probe that rolls around the target biomolecule. Users can adjust the size of the probe based on the characteristics of the target structure.", style = "text-align:justify",),
        tags$li(strong("Removal Distance (Å):"), " A length that is removed from the boundary between the cavity and bulk (solvent) region.", style = "text-align:justify",),
        tags$li(strong("Volume Cutoff (Å³):"), "A cavity volume filter to exclude cavities with smaller volumes than this limit. These smaller cavities are typically not relevant for function.", style = "text-align:justify",)
      )
    ),

    tags$br(),

    fluidRow(
      tags$p(
        "A schematic representation of cavity detection algorithm in KVFinder-web is presented below. In panel (A), a biomolecular structure X is inserted into a grid. In panel (B), Probe In (Pi) scans the surface of the structure, by translating over the grid points (orange). In panel (C), Probe Out (Po) scans the accessible points in blue. In panel (D), the cavity points (light grey) are defined as the difference between the probes' accessible points. The points not reached by Pi (dark grey) define the Solvent Excluded Surface (SES). In panel (E), a removal distance routine is applied to remove cavity points within a given distance from the cavity-bulk boundary (red line).",
        style = "text-align:justify",
      ),
      column(12, align = "center", tags$img(src = "www/kvfinder-web-schema.png", height = 400, width = 800, align = "center")),
    ),

    tags$br(),

    ## Impact of parameters on detection
    fluidRow(
      column(12, align = "center", tags$h5(strong("The impact of parameters on cavity detection"))),
      tags$p(
        "Two important parameters for cavity detection in KVFinder-web are Probe Out and Removal Distance, which directly impact execution time in KVFinder-web service.",
        style = "text-align:justify",
      ),
      tags$ul(
        tags$li(
          strong("Probe out: "),
          "is a larger probe that systematically translates in a Cartesian grid around the target biomolecule, defining the boundary between the cavity and the bulk (solvent) due to the restricted access to the empty space within the biomolecule. Thus, greater 'Probe Out' sizes tend to reduce the degree of accessibility of the molecular surface created and ultimately, increase the elapsed time to perform calculations in KVFinder-web service.",
          style = "text-align:justify",
        ),
        tags$li(
          strong("Removal Distance: "),
          "removes cavity points within a given length from the defined cavity-bulk boundary. Thus, reducing the 'Removal Distance' removes fewer points from the boundary, which helps to segregate sub-pockets and/or detect superficial cavities.",
          style = "text-align:justify",
        ),
      ),
    ),

    tags$br(),

    fluidRow(
      tags$p(
        "Apart from these parameters, the execution time of KVFinder-web increases linearly with the number of atoms of the target biomolecule inside the 3D grid. However, users can control the number of atoms by defining a custom search space around the ligand/molecule or residues, which can reduce the execution time.",
        style = "text-align:justify"
      ),
      column(12, align = "center", tags$img(src = "www/help_cav_adn.png", height = 220, width = 730, align = "center"))
    ),

    tags$br(),

    ## Cavity naming convention
    fluidRow(
      column(12, align = "center", tags$h5(strong("Cavity naming convention"))),
      tags$p(
        "The naming convention for cavities in KVFinder suite (parKVFinder, pyKVFinder and KVFinder-web) is based on the integer label assigned to each cavity in the 3D grid. The first cavity identified in the grid is labeled as KAA, the second as KAB, the third as KAC, and so on.",
        style = "text-align:justify",
        ),
      tags$p(
        "The integer labels are assigned using a DFS clustering algorithm, which identifies cavities in the order they are found in the 3D grid. The integer labels used in the algorithm are:",
        tags$ul(
          tags$li("-1: bulk (solvent);"),
          tags$li("0: biomolecule;"),
          tags$li("1: empty space (cavities that do not reach the volume cutoff);"),
          tags$li(">1: cavities."),
        ),
        style = "text-align:justify",
      ),
    ),

    tags$br(),

    ## Depth characterization
    fluidRow(
      column(12, align = "center", tags$h5(strong("Depth characterization"))),
      tags$p(
        "Depth characterization is a method used to identify the degree of burial of the binding site, with the largest and deepest cavity often corresponding to the active site in an enzymatic protein. This information can be helpful in identifying the active site throughout the molecular surface.",
        style = "text-align:justify",
      ),
      tags$p(
        "A schematic represention of the depth characterization is shown below. To perform depth characterization, a spatial filter is used to evaluate whether a cavity point (black) is a direct neighbor (red) of a bulk point, which assigns it as a boundary point (shown in panel A of the schematic). The distance between the cavity point (black) and the boundary points (red) is then calculated (shown in panel B of the schematic), and the shortest distance (blue line) is considered the depth of the cavity point. By calculating the depth of all cavity points, the maximum and average depths can be determined for each detected cavity.",
        style = "text-align:justify",
      ),
    ),
    fluidRow(
        column(12, align = "center", tags$img(src = "www/depth-characterization-scheme.png", height = 300, width = 600, align = "center")),
        column(12, align = "center", tags$p(
          "Source:",
          tags$a(
            href="https://doi.org/10.1016/j.softx.2020.100606",
            "Guerra et al. (2021)"
          ),
          ". License:",
          tags$a(
            href="https://creativecommons.org/licenses/by/4.0/",
            "CC BY 4.0"
          ),
          ".",
          align="center"
        )
      )
    ),

    tags$br(),

    ## Hydropathy characterization
    fluidRow(
      column(12, align = "center", tags$h5(strong("Hydropathy characterization"))),
      tags$p(
        "Hydropathy characterization provides valuable insights into the water attractiveness and types of interactions at the interface of the binding site.",
        style = "text-align:justify"
        ),
      tags$p(
        "A schematic represention of hydropathy characterization is shown below. The",
        tags$a(href="https://doi.org/10.1073/pnas.81.1.140", "Eisenberg & Weiss"),
        " hydrophobicity scale ranges from -1.42 (highly hydrophobic) to 2.6 (highly hydrophilic), and projects the value of the amino acid nearest to a target surface point. Panel A displays the hydrophobicity of each amino acid. The distance between a surface point (black) and the atoms (carbon: green; oxygen: red; nitrogen: blue; sulfur: yellow) of the amino acids (methionine: left; valine: right) are calculated, and the residue of the atom with shortest distance (red line) maps its hydrophobicity value onto it (shown in panel B).",
        style = "text-align:justify"
      ),
    ),
    fluidRow(
        column(12, align = "center", tags$img(src = "www/hydropathy-characterization-scheme.png", height = 400, width = 800, align = "center")),
        column(12, align = "center", tags$p(
          "Modified from:",
          tags$a(
            href="https://doi.org/10.1016/j.softx.2020.100606",
            "Guerra et al. (2021)"
          ),
          ". License:",
          tags$a(
            href="https://creativecommons.org/licenses/by/4.0/",
            "CC BY 4.0"
          ),
          ".",
          align="center"
        )
      )
    ),

    tags$br(),

    ## Requirements and limitations
    fluidRow(
      column(12, align = "center", tags$h5(strong("KVFinder-web service requirements and limitations"))),
      tags$p(
        "The KVFinder-web service has a Job timeout of 30 minutes (the maximum time that an accepted job could run on the server), completed jobs will be available on the web service up to 1 day after completion, and the maximum payload (maximum size of the JSON) of the data sent to the KVFinder-web service is 1 MB.",
        style = "text-align:justify"
      ),
      tags$p(
        "Further, the KVFinder-web service has some limitations, compared to a local installation of parKVFinder, that are:",
        style = "text-align:justify"
      ),
      tags$ol(
        tags$li(
          "The Probe In and Probe Out sizes must be smaller than 5 and 50 A, respectively, to avoid unnecessary time-consuming jobs."
        ),
        tags$li(
          "The Removal distance is limited and must be smaller than 10 A to avoid unnecessary time-consuming jobs."
        ),
        tags$li(
          "The grid spacing is preset to 0.6 A to avoid unnecessary time-consuming jobs."
        ),
        tags$li(
          "Cavity representation will be always filtered (cavity files will consume less space on the web service)."
        )
      ),
      tags$p(
        "This website is free and open to all users and there is no login requirement.",
        style = "text-align:justify"
      )
    )
  )
}
