#' Create radio buttons of the run mode in main Run KVFinder page
#'
#' @import shiny
#'
#' @export
#'


kv_about <- function() {
  fluidPage(
    # About topic
    fluidRow(
      column(12, align = "center", tags$h3("About KVFinder"))
    ),
    tags$br(),
    tags$br(),

    ## Brief KVFinder project description
    fluidRow(
      column(12, align = "center", tags$h5(strong("The KVFinder project")))
    ),
    tags$p("KVFinder project comprises a collection of cavity detection and characterization software with different scopes, which are parKVFinder, pyKVFinder and KVFinder-web service."),
    tags$br(),

    ## KVFinder-web service description
    tags$h5(strong("KVFinder-web service")),
    tags$p("KVFinder-web service is a RESTful web service that runs parKVFinder software to detect and chacterize cavities. The web service has Web-Queue-Worker architecture style and each of these modules is built in a separated Docker container, making available to execute on different platforms and Cloud services."),
    tags$p("The KVFinder-web service interface was developed using Shiny R package. Structure preprocessing is performed with Bio3D R package and molecular visualization uses the NGLVieweR engine."),
    tags$p(
      strong("Citing:"),
      "If you used",
      tags$a(
        href = "https://github.com/LBC-LNBio/KVFinder-web-service",
        "KVFinder-web service"
      ),
      ", please refer to:",
      style = "text-align:justify"
    ),
    tags$p("Manuscript in submission"),
    tags$br(),

    ## parKVFinder description
    tags$h5(strong("parKVFinder")),
    tags$p(
      "Parallel KVFinder (parKVFinder) is open-source (GPL v3.0) software designed for detection and spatial characterization of any type of biomolecular cavity. ParKVFinder inserts the target biomolecule in a 3D grid divided by regular voxels and applies a dual-probe algorithm, originally implemented in KVFinder. parKVFinder provides accurate, fast and efficient steered detection and spatial characterization (shape, volume, area and surrounding residues), with a multithreaded parallelization implemented with OpenMP. Cavity detection relies on a set of intuitive customizable parameters, which user may interact via a graphical user interface (GUI) or a command-line interface.",
      style = "text-align:justify"
    ),
    tags$p(
      "For more information on ",
      tags$a(
        href = "https://github.com/LBC-LNBio/parKVFinder",
        "parKVFinder",
      ),
      ", please refer to: ",
      style = "text-align:justify"
    ),
    tags$p(
      "João Victor da Silva Guerra, Helder Veras Ribeiro Filho, Leandro Oliveira Bortot, Rodrigo Vargas Honorato, José Geraldo de Carvalho Pereira, Paulo Sergio Lopes de Oliveira, ParKVFinder: A thread-level parallel approach in biomolecular cavity detection, SoftwareX, 2020, ",
      tags$a(
        href = "https://doi.org/10.1016/j.softx.2020.100606",
        "https://doi.org/10.1016/j.softx.2020.100606"
      ),
      ".",
      style = "text-align:justify"
    ),
    tags$br(),

    ## pyKVFinder description
    tags$h5(strong("pyKVFinder")),
    tags$p(
      "In the data-intensive cavity analysis scenario, pipelines require efficient scripting routines built on easily manipulated data structures. To cover this requirement, we developed Python-C Parallel KVFinder, pyKVFinder, an open-source (GPL v3.0) Python package to detect and characterize cavities in biomolecular structures for data science and automated pipelines. In pyKVFinder, the target biomolecule is inserted into a regular 3D grid, which is stored as an N-dimensional array (ndarray). To detect cavities, pyKVFinder uses a dual-probe algorithm that scans the biomolecular structure, as described in KVFinder and parKVFinder. Besides conventional cavity properties such as volume, area and interface residues, pyKVFinder computes cavity depth and hydropathy. Thus, pyKVFinder facilitates biostructural data analysis with scripting routines in the Python ecosystem and can be building blocks for data science and drug design applications.",
      style = "text-align:justify"
    ),
    tags$p(
      "For more information on ",
      tags$a(
        href = "https://github.com/LBC-LNBio/pyKVFinder",
        "pyKVFinder",
      ),
      ", please refer to: ",
      style = "text-align:justify"
    ),
    tags$p(
      "Guerra, J.V.d., Ribeiro-Filho, H.V., Jara, G.E. et al. pyKVFinder: an efficient and integrable Python package for biomolecular cavity detection and characterization in data science. BMC Bioinformatics 22, 607 (2021). ",
      tags$a(
        href = "https://doi.org/10.1186/s12859-021-04519-4",
        "https://doi.org/10.1186/s12859-021-04519-4"
      ),
      ".",
      style = "text-align:justify"
    ),
    tags$br(),
    tags$br(),

    # Troubleshooting topic
    fluidRow(
      column(12, align = "center", tags$h5(strong("Troubleshooting")))
    ),
    tags$p(
      "KVFinder-web service uses of GitHub for project management. Please help us by reporting any problems or requests."
    ),
    tags$p("On Issues page, you can file a:"),
    tags$li(
      tags$a(
        href = "https://github.com/LBC-LNBio/KVshiny-docker/issues/new?assignees=&labels=&template=bug_report.md&title=",
        "Bug Report"
      ),
    ),
    tags$li(
      tags$a(
        href = "https://github.com/LBC-LNBio/KVshiny-docker/issues/new?assignees=&labels=&template=feature_request.md&title=",
        "Request for a new feature"
      ),
    ),
    tags$br(),
    tags$p(
      "Only make sure the bug or request has not already been reported. Click on “Search” and enter some keywords to search.",
      style = "text-align:justify"
    ),
    tags$p(
      "Thank you for helping us improve KVFinder-web service!",
      style = "text-align:justify"
    ),
    tags$br(),
    tags$br(),

    # Development team topic
    fluidRow(
      column(12, align = "center", tags$h5(strong("Development Team")))
    ),
    tags$p(
      "KVFinder-web service is developed by:",
      style = "text-align:justify"
    ),
    tags$li("João Victor da Silva Guerra"),
    tags$li("Helder Veras Ribeiro-Filho"),
    tags$li("José Geraldo de Carvalho Pereira"),
    tags$li("Paulo Sergio Lopes-de-Oliveira (Principal Investigator)"),
    tags$br(),
    tags$p(
      "Computational Biology Laboratory (",
      tags$a(
        href = "https://github.com/LBC-LNBio",
        "LBC"
      ),
      "), Brazilian Biosciences National Laboratory (",
      tags$a(
        href = "https://lnbio.cnpem.br",
        "LNBio"
      ),
      "), Brazilian Center for Research in Energy and Materials (",
      tags$a(
        href = "https://cnpem.br",
        "CNPEM"
      ),
      ")",
      style = "text-align:justify"
    ),
    tags$br(),
    tags$h5("Laboratory of Computational Biology - Staff"),
    tags$li("Gabriel Ernesto Jara"),
    tags$li("Helder Veras Ribeiro Filho"),
    tags$li("João Victor da Silva Guerra"),
    tags$li("José Geraldo de Carvalho Pereira"),
    tags$li("Leandro Oliveira Bortot"),
    tags$li("Luiz Fernando Giolo Alves"),
    tags$li("Paulo Sergio Lopes de Oliveira (Principal Investigator)"),
    tags$br(),
    tags$br(),

    # Contact topic
    fluidRow(
      column(12, align = "center", tags$h5(strong("Contact")))
    ),
    tags$p(
      "If you have any further questions, inquires or if you wish to contribute to KVFinder project, please contact us at ",
      tags$a(
        href = "mailto:joao.guerra@lnbio.cnpem.br",
        "joao.guerra@lnbio.cnpem.br"
      ),
      " or ",
      tags$a(
        href = "mailto:paulo.oliveira@lnbio.cnpem.br",
        "paulo.oliveira@lnbio.cnpem.br"
      ),
      ".",
      style = "text-align:justify"
    ),
    tags$br(),
    tags$br(),

    # License topic
    fluidRow(
      column(12, align = "center", tags$h5(strong("License")))
    ),
    tags$p(
      "parKVFinder software is licensed under the terms of the Apache-2.0 License and is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the Apache-2.0 License for more details.",
      style = "text-align:justify"
    )
  )
}
