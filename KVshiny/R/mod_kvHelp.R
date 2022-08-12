#' Function that creates the help page of the KVFinder server
#' 
#' @import shiny
#' @export
#' 


kv_help <- function(){
  fluidPage(
  fluidRow(column(12,
      align="center",
      tags$h3("KVFinder help page"))),
  tags$br(),
  fluidRow(column(12, align = "center",
      tags$h5(strong("Overview")))),
  fluidRow(
    tags$p("KVFinder-web service implements a geometrical grid-and-sphere based method to detect cavities in biomolecular structures,
                     such as proteins and nucleic acids, using a dual-probe system.
                     A detailed description of this method can be found in:",
           tags$a(href="https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-021-04519-4", " Oliveira et al. 2014,"),
           tags$a(href="https://www.sciencedirect.com/science/article/pii/S2352711020303198#sec1"," Guerra et al. 2020,"),
           tags$a(href="https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-021-04519-4", " Guerra et al. 2021."),
           style= "text-align:justify"),
    tags$br()),

  fluidRow(column(12, align = "center",
        tags$h5(strong("Setting parameters:"))),
        tags$li(strong("Probe In:"), "A smaller probe that rolls around the target biomolecule, defining its surface. Usually, it is set to a water molecule (1.4 Å)."),
        tags$li(strong("Probe Out:"), "A larger probe that rolls around the target biomolecule. Depending on the characteristics of the target structure, user may adjust probe size."),
        tags$br(),
        tags$br(),
        tags$p("A schematic representation of the dual-probe routine is presented below.")
  ),
  fluidRow(column(12, align = "center",
    tags$img(src = "www/fig_dualprobe.png", height = 400, width = 700, align = "center")),
    tags$br(),
    tags$br(),
    tags$br(),
    tags$br()
  ),
  fluidRow(column(12, align = "left",
    tags$br(),
    tags$br(),
    tags$br(),
    tags$li(strong("Removal Distance (Å):"), "A length to remove from the cavity-bulk boundary.")),
    tags$br(),
    tags$br()
    ),
  tags$br(),
  tags$br(),
  fluidRow(tags$br(),
  tags$br(),
  tags$p("A schematic representation of the removal distance routine is shown below.")),
  fluidRow(column(12, align="center",
                  tags$br(),
      tags$img(src = "www/fig_removaldist.png", height = 400, width = 1000, align = "center"),
      tags$br(),
      tags$br()),
      tags$br(),
      tags$br(),
      tags$br(),
      tags$br()
  ),
  tags$br(),
  fluidRow(
  tags$li(strong("Volume Cutoff (Å³):"), "A cavity volume filter to exclude cavities with smaller volumes than this limit. This parameter is useful for removing uninteresting cavities from cavity detection.")        
  ),
  fluidRow(column(12, align="center",
                tags$br(),
                tags$br(),
                tags$h5(strong("Main impact of parameters on the cavity detection:"))),
                tags$li(strong("Probe out:"), "the Probe Out translates the biomolecular structure to create a molecular surface,
                       producing the boundary between the cavity and the bulk due to the restricted access to the empty space within the protein.
                      Thus, greater Probe Out sizes tend to reduce the degree of accessibility of the molecular surface created and ultimately,
                       increasing the elapsed time to perform calculations in KVFinder-web service."),
                tags$li(strong("Removal Distance:"), "the Removal Distance removes cavity points within a given length from the defined cavity-bulk boundary.
                               Thus, reducing the Removal Distance parameter removes less points from the boundary,
                               which helps to segregate sub-pockets and/or detect superficial cavities. "),
                tags$br(),
                tags$p("Independently of these parameters, the execution time increases linearly with the number of atoms of the target biomolecule inside the 3D grid.
                              Hence, the number of atoms can be controlled by a custom search space (around ligand/molecule or residues), which can reduce the elapsed time.")
  ),
  fluidRow(column(12, align="center",
                  tags$img(src = "www/fig_kv_adenosine.png", height = 220, width = 730, align = "center"))
  ),
  fluidRow(column(12, align="center",
             tags$br(),
             tags$br(),
             tags$br(),
             tags$h5(strong("KVFinder-web service requirements and limitations"))),
             tags$p("The KVFinder-web service has a Job timeout of 30 minutes (maximum time that a accepted job could run on the server),
                              completed jobs will be available on the web service up to 1 day after completion,
                              and the maximum payload (maximum size of the JSON) of the data sent to the KVFinder-web service is 1 MB."),
             tags$p("Further, the KVFinder-web service has some limitations, compared to a local installation of parKVFinder, that are: "),
             tags$ol(
             tags$li("The Probe In and Probe Out sizes must be smaller than to 5 and 50 A, respectively, to avoid unnecessary time-consuming jobs."),
             tags$li("The Removal distance is limited must be smaller than 10 A to avoid unnecessary time-consuming jobs."),
             tags$li("The grid spacing is preset to 0.6 A to avoid unnecessary time-consuming jobs."),
             tags$li("Cavity representation will be always filtered (cavity files will consume less space on the web service).")
            )
  )
  )
}
