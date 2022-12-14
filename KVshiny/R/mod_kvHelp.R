#' Function that creates the help page of the KVFinder server
#'
#' @import shiny
#' @export
#'


kv_help <- function() {
  fluidPage(
    # Help topic
    fluidRow(
      column(12, align = "center", tags$h3("KVFinder-web help page"))
    ),
    tags$br(),
    tags$br(),

    ## Overview description
    fluidRow(
      column(12, align = "center", tags$h5(strong("Overview")))
    ),
    tags$p(
      "KVFinder-web service implements a geometrical grid-and-sphere based method to detect cavities in biomolecular structures, such as proteins and nucleic acids, using a dual-probe system. A detailed description of this method can be found in: ",
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
    tags$br(),

    ## Detection parameters
    fluidRow(
      column(12, align = "center", tags$h5(strong("Detection parameters:")))
    ),

    ### Probes
    fluidRow(
     tags$ul(
      tags$li(strong("Probe In:"), "A smaller probe that rolls around the target biomolecule, defining its surface. Usually, it is set to a water molecule (1.4 Å)."),
      tags$li(strong("Probe Out:"), "A larger probe that rolls around the target biomolecule. Depending on the characteristics of the target structure, the user may adjust probe size."),
     )
    ),
    tags$br(),
    tags$p(
      "A schematic representation of the dual-probe routine is presented below."
    ),
    tags$br(),
    fluidRow(
      column(12, align = "center", tags$img(src = "www/fig_dualprobe.png", height = 400, width = 700, align = "center")),
    ),
    tags$br(),

    ### Removal distance
    fluidRow(
      tags$li(
        strong("Removal Distance (Å):"),
        "A length to remove from the cavity-bulk boundary."
      ),
    ),
    tags$br(),
    tags$p("A schematic representation of the removal distance routine is shown below."),
    tags$br(),
    fluidRow(
      column(12, align = "center", tags$img(src = "www/fig_removaldist.png", height = 400, width = 1000, align = "center")),
    ),
    tags$br(),

    ### Volume Cutoff
    fluidRow(
     tags$ul(
      tags$li(
        strong("Volume Cutoff (Å³):"),
        "A cavity volume filter to exclude cavities with smaller volumes than this limit. This parameter is useful for removing uninteresting cavities from cavity detection."
      )
     )
    ),
    tags$br(),
    tags$br(),

    ## Impact of parameters on detection
    fluidRow(
      column(12, align = "center", tags$h5(strong("The main impact of parameters on cavity detection:"))),
     tags$ul(
      tags$li(
        strong("Probe out:"),
        "the Probe Out translates the biomolecular structure to create a molecular surface, producing the boundary between the cavity and the bulk due to the restricted access to the empty space within the protein. Thus, greater Probe Out sizes tends to reduce the degree of accessibility of the molecular surface created and ultimately, increasing the elapsed time to perform calculations in KVFinder-web service."
      ),
      tags$li(
        strong("Removal Distance:"),
        "the Removal Distance removes cavity points within a given length from the defined cavity-bulk boundary. Thus, reducing the Removal Distance parameter removes fewer points from the boundary, which helps to segregate sub-pockets and/or detect superficial cavities."
      ),
     ),
    ),
    tags$br(),
    tags$p(
      "Independently of these parameters, the execution time increases linearly with the number of atoms of the target biomolecule inside the 3D grid. Hence, the number of atoms can be controlled by a custom search space (around ligand/molecule or residues), which can reduce the elapsed time.",
      style = "text-align:justify"
    ),
    fluidRow(
      column(12, align = "center", tags$img(src = "www/fig_kv_adenosine.png", height = 220, width = 730, align = "center"))
    ),
    tags$br(),
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
