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
      column(12, align = "center", tags$h3(strong("About KVFinder-web")))
    ),
    tags$br(),
    tags$br(),

    ## Brief KVFinder project description
    fluidRow(
      column(12, align = "center", tags$h5(strong("The KVFinder suite")))
    ),
    tags$p(
      "KVFinder suite comprises a toolkit of cavity detection and characterization software with different scopes, that are:",
      tags$ul(
        tags$li(
          tags$a(
            href = "https://github.com/LBC-LNBio/KVFinder-web",
            "KVFinder-web"
          )
        ),
        tags$li(
          tags$a(
            href = "https://github.com/LBC-LNBio/parKVFinder",
            "parKVFinder"
          )
        ),
        tags$li(
          tags$a(
            href = "https://github.com/LBC-LNBio/pyKVFinder",
            "pyKVFinder"
          )
        ),
      ),
    ),

    tags$br(),

    ## KVFinder-web description
    tags$h5(strong("KVFinder-web")),
    tags$p(
      "KVFinder-web is an open-source web-based application of an updated version of ",
      tags$a(
        href = "https://github.com/LBC-LNBio/parKVFinder",
        "parKVFinder"
      ),
      " software (v1.2.0) for cavity detection and characterization of any type of biomolecular structure, including but not limited to proteins and nucleic acids. KVFinder-web implements a geometrical grid-and-sphere based method to detect cavities using a dual-probe system. KVFinder-web provides a comprehensive characterization of biomolecular cavities that includes spatial, depth, constitutional, and hydropathy information."
    ),
    tags$p(
      "The KVFinder-web has two independent components:",
      tags$ul(
        tags$li(
          "a RESTful web service: ", 
          tags$a(
            href = "https://github.com/LBC-LNBio/KVFinder-web-service",
            "KVFinder-web service"
          ),
        ),
        tags$li(
          "a graphical web portal: ", 
          tags$a(
            href = "https://github.com/LBC-LNBio/KVFinder-web-portal",
            "KVFinder-web portal"
            ),
        ),
      ),
    ),
    tags$h6(strong("Citing")),
    tags$p(
      "If you use ",
      tags$a(
        href = "https://github.com/LBC-LNBio/KVFinder-web",
        "KVFinder-web"
      ),
      ", please cite:",
      tags$ol(
        tags$li("Manuscript in submission"),
        tags$li(
          "João Victor Da Silva Guerra, Helder Veras Ribeiro filho, Leandro Oliveira Bortot, Rodrigo Vargas Honorato, José Geraldo De Carvalho Pereira, and Paulo Sérgio Lopes-de-oliveira. ParKVFinder: a thread-level parallel approach in biomolecular cavity detection. SoftwareX, 12:100606, July 2020. URL: ",
          tags$a(href = "https://doi.org/10.1016/j.softx.2020.100606", "https://doi.org/10.1016/j.softx.2020.100606"),
          ", doi:10.1016/j.softx.2020.100606."),
      ),
      style = "text-align:justify"
    ),
    tags$p(
      "If you use depth and hydropathy characterization, please also cite:",
      tags$ol(
        tags$li("João Victor da Silva Guerra, Helder Veras Ribeiro-Filho, Gabriel Ernesto Jara, Leandro Oliveira Bortot, José Geraldo de Carvalho Pereira, and Paulo Sérgio Lopes-de-Oliveira. pyKVFinder: an efficient and integrable python package for biomolecular cavity detection and characterization in data science. BMC Bioinformatics, December 2021. URL: ",
        tags$a(href = "https://doi.org/10.1186/s12859-021-04519-4", "https://doi.org/10.1186/s12859-021-04519-4"),
        ", doi:10.1186/s12859-021-04519-4."), start=3,
      ),
      style = "text-align:justify"
    ),
    
    tags$br(),

    ## parKVFinder description
    tags$h5(strong("parKVFinder")),
    tags$p(
      "Parallel KVFinder (parKVFinder) is a powerful open-source software designed to detect and comprehensively characterize biomolecular cavities of any type. It provides detailed information on the spatial, depth, constitutional, and hydropathy characteristics of each cavity. The cavity detection process relies on a customizable set of intuitive parameters that users can interact with via a graphical user interface (GUI) or a command-line interface.",
      style = "text-align:justify"
    ),
    tags$p(
      "The spatial characterization of each cavity includes information on its shape, volume, and surface area. The depth characterization determines the depth of each cavity point, shown in the B-factors, and calculates the average and maximum depth per cavity. The constitutional characterization identifies the amino acids that form the identified cavities. Lastly, the hydropathy characterization maps the Eisenberg & Weiss hydrophobicity scale onto the surface points of each cavity, shown in the Q-factor, and estimates the average hydropathy for each cavity.",
      style = "text-align:justify"
    ),
    tags$p(
      "For more information on ",
      tags$a(
        href = "https://github.com/LBC-LNBio/parKVFinder",
        "parKVFinder",
      ),
      ", please refer to: ",
      tags$a(href="https://doi.org/10.1016/j.softx.2020.100606", "[2]"),
      style = "text-align:justify"
    ),

    tags$br(),

    ## pyKVFinder description
    tags$h5(strong("pyKVFinder")),
    tags$p(
      "Cavity analysis can be a data-intensive process that requires efficient scripting routines built on easily manipulated data structures. To address this need, we developed Python-C Parallel KVFinder (pyKVFinder), an open-source (GPL v3.0) Python package to detect and characterize cavities in biomolecular structures for data science and automated pipelines.",
      style = "text-align:justify"
    ),  
    tags$p(
      "pyKVFinder uses a dual-probe algorithm to scan the biomolecular structure inserted into a regular 3D grid stored as an N-dimensional array (ndarray). The software detects cavities and provides comprehensive information on their spatial, depth, constitutional, and hydropathy characteristics.",
      style = "text-align:justify"
    ),
    tags$p(
      "pyKVFinder is specifically designed to facilitate biostructural data analysis in the Python ecosystem and is an essential building block for data science and drug design applications. It is an excellent choice for automated pipelines that require efficient and fast processing of large datasets. With pyKVFinder, researchers and developers can easily manipulate and process cavity data structures to extract valuable insights and develop new drugs or biomolecular applications.",
      style = "text-align:justify"
    ),
    tags$p(
      "For more information on ",
      tags$a(href = "https://github.com/LBC-LNBio/pyKVFinder", "pyKVFinder"),
      ", please refer to: ",
      tags$a(href = "https://doi.org/10.1186/s12859-021-04519-4", "[3]"),
      style = "text-align:justify"
    ),

    tags$br(),

    # Troubleshooting topic
    fluidRow(
      column(12, align = "center", tags$h5(strong("Troubleshooting")))
    ),
    tags$p(
      "If you encounter any issues or have requests related to the KVFinder-web service, please don't hesitate to inform us so that we can make improvements. We manage our project through GitHub and you can use our ",
      tags$a(href="https://github.com/LBC-LNBio/KVFinder-web-portal/issues", "Issues"),
      " page to either:",
      tags$ul(
        tags$li(
          tags$a(
            href="https://github.com/LBC-LNBio/KVFinder-web-portal/issues/new?assignees=&labels=&template=bug_report.md&title=",
            "report a bug"
          ),
          ";",
        ),
        tags$li(
          tags$a(
            href="https://github.com/LBC-LNBio/KVFinder-web-portal/issues/new?assignees=&labels=&template=feature_request.md&title=",
            "request a new feature"
          ),
          "."
        ),
      ),
      style = "text-align:justify"
    ),
    tags$p(
      "Before submitting your report or request, please make sure it has not already been reported by using the search function to look for keywords.",
      style = "text-align:justify"
    ),

    tags$br(),

    # Development team topic
    fluidRow(
      column(12, align = "center", tags$h5(strong("Development Team")))
    ),
    tags$p(
      "The following team develops and maintains KVFinder-web:",
      style = "text-align:justify"
    ),
    tags$ul(
      tags$li("João Victor da Silva Guerra"),
      tags$li("Helder Veras Ribeiro-Filho"),
      tags$li("José Geraldo de Carvalho Pereira"),
      tags$li("Paulo Sergio Lopes-de-Oliveira (Principal Investigator)"),
    ),
    tags$br(),
    tags$p(
      "The team belongs to the Computational Biology Laboratory (",
      tags$a(
        href = "https://github.com/LBC-LNBio",
        "LBC"
      ),
      ") at the Brazilian Biosciences National Laboratory (",
      tags$a(
        href = "https://lnbio.cnpem.br",
        "LNBio"
      ),
      ") in the Brazilian Center for Research in Energy and Materials (",
      tags$a(
        href = "https://cnpem.br",
        "CNPEM"
      ),
      ")",
      style = "text-align:justify"
    ),
    
    tags$br(),
    
    tags$h5("LBC Staff"),
    tags$ul(
      tags$li("Gabriel Ernesto Jara"),
      tags$li("Helder Veras Ribeiro Filho"),
      tags$li("João Victor da Silva Guerra"),
      tags$li("José Geraldo de Carvalho Pereira"),
      tags$li("Leandro Oliveira Bortot"),
      tags$li("Paulo Sergio Lopes de Oliveira (Principal Investigator)"),
    ),

    tags$br(),

    # Contact topic
    fluidRow(
      column(12, align = "center", tags$h5(strong("Contact")))
    ),
    tags$p(
      "If you have any questions, inquiries, or wish to contribute to the KVFinder suite, please feel free to contact us. You can reach us via email at ",
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

    # Funding topic
    fluidRow(
      column(12, align = "center", tags$h5(strong("Funding")))
    ),
    tags$p(
      "The KVFinder-web software was supported by Fundação de Amparo à Pesquisa do Estado de São Paulo (FAPESP) [Grant Number 2018/00629-0], Brazilian Biosciences National Laboratory (LNBio) and Brazilian Center for Research in Energy and Materials (CNPEM).",
      style = "text-align:justify"
    ),

    tags$br(),

    # License topic
    fluidRow(
      column(12, align = "center", tags$h5(strong("License")))
    ),
    tags$p(
      "The KVFinder-web software is licensed under the terms of the Apache-2.0 License and is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the Apache-2.0 License for more details.",
      style = "text-align:justify"
    )
  )
}
