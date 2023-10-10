#' Create radio buttons of the run mode in main Run KVFinder page
#'
#' @import shiny
#'
#' @export
#'

kv_about <- function() {

  fluidPage(

    # About topic
    tags$h2(
      strong("About"),
      style = "text-align: center;"
    ),
    tags$br(),

    # KVFinder-suite
    tags$h4(
      strong("The KVFinder suite"),
      style = "text-align: center;"
    ),
    tags$br(),
    tags$p(
      "The KVFinder suite encompasses a toolkit of cavity detection and \ 
      characterization software with various scopes, including:",
      style = "text-align:justify"
    ),
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

    # KVFinder-web
    tags$h5(
      strong("KVFinder-web"),
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
      "). It is designed for cavity detecting and characterizing cavities \ 
      within diverse biomolecular structures, including but not limited to \ 
      proteins and nucleic acids. KVFinder-web implements a geometric \ 
      grid-and-sphere based method to detect cavities using a dual-probe \ 
      system. It provides a comprehensive characterization of biomolecular \ 
      cavities that includes spatial, depth, constitutional, and hydropathy \ 
      information.",
      style = "text-align:justify"
    ),
    tags$p(
      "KVFinder-web consists of two independent components:",
      tags$ul(
        tags$li(
          "A RESTful web service: ",
          tags$a(
            href = "https://github.com/LBC-LNBio/KVFinder-web-service",
            "KVFinder-web service"
          ),
        ),
        tags$li(
          "A graphical web portal: ",
          tags$a(
            href = "https://github.com/LBC-LNBio/KVFinder-web-portal",
            "KVFinder-web portal"
            ),
        ),
      ),
    ),
    tags$h6(
      strong("Citing:")
    ),
    tags$p(
      "If you use ",
      tags$a(
        href = "https://github.com/LBC-LNBio/KVFinder-web",
        "KVFinder-web"
      ),
      ", please cite:",
      tags$ol(
        tags$li(
          "João V.S. Guerra, Helder V. Ribeiro-Filho, José G.C. Pereira, \ 
          and Paulo S. Lopes-de-oliveira. KVFinder-web: a web-based \ 
          application for detecting and characterizing biomolecular \ 
          cavities. Nucleic Acids Research, May 2023. URL: ",
          tags$a(
            href = "https://doi.org/10.1093/nar/gkad324",
            "https://doi.org/10.1093/nar/gkad324"
          ),
          ", doi:10.1016/10.1093/nar/gkad324."
        ),
        tags$li(
          "João Victor Da Silva Guerra, Helder Veras Ribeiro Filho, \ 
          Leandro Oliveira Bortot, Rodrigo Vargas Honorato, José Geraldo \ 
          De Carvalho Pereira, and Paulo Sérgio Lopes-de-oliveira. \ 
          ParKVFinder: a thread-level parallel approach in biomolecular \ 
          cavity detection. SoftwareX, 12:100606, July 2020. URL: ",
          tags$a(
            href = "https://doi.org/10.1016/j.softx.2020.100606",
            "https://doi.org/10.1016/j.softx.2020.100606"
          ),
          ", doi:10.1016/j.softx.2020.100606."
        ),
      ),
      style = "text-align:justify"
    ),
    tags$p(
      "If you use depth and hydropathy characterization, please also cite:",
      tags$ol(
        tags$li(
          "João Victor da Silva Guerra, Helder Veras Ribeiro-Filho, \ 
          Gabriel Ernesto Jara, Leandro Oliveira Bortot, José Geraldo \ 
          de Carvalho Pereira, and Paulo Sérgio Lopes-de-Oliveira. \ 
          pyKVFinder: an efficient and integrable python package for \ 
          biomolecular cavity detection and characterization in data \ 
          science. BMC Bioinformatics, December 2021. URL: ",
          tags$a(
            href = "https://doi.org/10.1186/s12859-021-04519-4",
            "https://doi.org/10.1186/s12859-021-04519-4"
          ),
          ", doi:10.1186/s12859-021-04519-4."
        ),
        start = 3,
      ),
      style = "text-align:justify"
    ),

    # parKVFinder
    tags$h5(
      strong("parKVFinder"),
      style = "text-align: center;"
    ),
    tags$br(),
    tags$p(
      "Parallel KVFinder (parKVFinder) is a robust open-source software \ 
      tailored to detect and comprehensively characterize biomolecular \ 
      cavities of all types. It offers detailed insights into the spatial, \ 
      depth, constitutional, and hydropathy characteristics of each cavity. \ 
      The software allows users to interact with an intuitive set of \ 
      customizable parameters via a graphical user interface (GUI) or a \ 
      command-line interface.",
      tags$br(),
      "Each cavity is spatially characterized in terms of its shape, volume, \ 
      and surface area. Depth characterization reveals the depth of each \ 
      cavity point, displayed as B-factors, and computes average and maximum \ 
      depth per cavity. Constitutional characterization identifies the amino \ 
      acids constituting the identified cavities. Lastly, hydropathy \ 
      characterization maps the Eisenberg & Weiss hydrophobicity scale onto \ 
      the surface points of each cavity, represented as the Q-factor, and \ 
      estimates the average hydropathy for each cavity.",
      style = "text-align:justify"
    ),
    tags$p(
      "For more information on ",
      tags$a(
        href = "https://github.com/LBC-LNBio/parKVFinder",
        "parKVFinder",
      ),
      ", please refer to: ",
      tags$a(
        href = "https://doi.org/10.1016/j.softx.2020.100606",
        "[2]"
      ),
      style = "text-align:justify"
    ),

    # pyKVFinder
    tags$h5(
      strong("pyKVFinder"),
      style = "text-align: center;"
    ),
    tags$br(),
    tags$p(
      "Cavity analysis often involves handling substantial data and \ 
      necessitates efficient scripting routines built on easily manipulable \ 
      data structures. Addressing this need, we developed Python-C Parallel \ 
      KVFinder (pyKVFinder), an open-source (GPL v3.0) Python package \ 
      designed for detecting and characterizing cavities in biomolecular \ 
      structures for data science and automated pipelines.",
      tags$br(),
      "pyKVFinder employs a dual-probe algorithm to scan the biomolecular \ 
      structure within a regular 3D grid stored as an N-dimensional array \ 
      (ndarray). The software detects cavities and provides comprehensive \ 
      information regarding their spatial, depth, constitutional, and \ 
      hydropathy characteristics.",
      tags$br(),
      "Specifically designed to streamline biostructural data analysis within \ 
      the Python ecosystem, pyKVFinder is a crucial asset for data science \ 
      and drug design applications. It excels in automated pipelines \ 
      requiring efficient and rapid processing of extensive datasets. \ 
      Researchers and developers can seamlessly manipulate and process \ 
      cavity data structures with pyKVFinder to extract valuable insights \ 
      and develop new drugs or biomolecular applications.",
      style = "text-align:justify"
    ),
    tags$p(
      "For more information on ",
      tags$a(href = "https://github.com/LBC-LNBio/pyKVFinder", "pyKVFinder"),
      ", please refer to: ",
      tags$a(href = "https://doi.org/10.1186/s12859-021-04519-4", "[3]"),
      style = "text-align:justify"
    ),
    tags$hr(),

    # Development Team
    tags$h4(
      strong("Development Team"),
      style = "text-align: center;"
    ),
    tags$br(),
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
      "This team operates within the Computational Biology Laboratory (",
      tags$a(
        href = "https://github.com/LBC-LNBio",
        "LBC"
      ),
      ") at the Brazilian Biosciences National Laboratory (",
      tags$a(
        href = "https://lnbio.cnpem.br",
        "LNBio"
      ),
      ") under the Brazilian Center for Research in Energy and Materials (",
      tags$a(
        href = "https://cnpem.br",
        "CNPEM"
      ),
      ")",
      style = "text-align:justify"
    ),
    tags$br(),
    tags$h5(
      tags$strong("LBC Staff"),
      style = "text-align: center;"
    ),
    tags$br(),
    tags$ul(
      tags$li("Amauri Donadon Leal Junior"),
      tags$li("Gabriel Ernesto Jara"),
      tags$li("Helder Veras Ribeiro Filho"),
      tags$li("João Victor da Silva Guerra"),
      tags$li("José Geraldo de Carvalho Pereira"),
      tags$li("Leandro Oliveira Bortot"),
      tags$li("Marcos Rogério Simões"),
      tags$li("Pablo Wesley de Aguiar e Silva"),
      tags$li("Patrick Hideki Fuzimoto Alvares"),
      tags$li("Paulo Sergio Lopes de Oliveira (Principal Investigator)"),
    ),
    tags$hr(),

    # Contact
    tags$h4(
      strong("Contact"),
      style = "text-align: center;"
    ),
    tags$br(),
    tags$p(
      "For questions, inquiries, or contributions to the KVFinder suite, \ 
      please contact us via email at ",
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

    # Troubleshooting
    tags$h5(
      strong("Troubleshooting"),
      style = "text-align: center;"
    ),
    tags$br(),
    tags$p(
      "If you encounter any issues or have requests related to the \ 
      KVFinder-web, please inform us  to facilitate improvements. \ 
      Our project is managed on GitHub, and you can use our ",
      tags$a(
        href = "https://github.com/LBC-LNBio/KVFinder-web-portal/issues",
        "Issues"
      ),
      " page to:",
      tags$ul(
        tags$li(
          tags$a(
            href = "https://github.com/LBC-LNBio/KVFinder-web-portal/issues/new?assignees=&labels=&template=bug_report.md&title=",
            "Report a bug"
          ),
          ";",
        ),
        tags$li(
          tags$a(
            href = "https://github.com/LBC-LNBio/KVFinder-web-portal/issues/new?assignees=&labels=&template=feature_request.md&title=",
            "Request a new feature"
          ),
          "."
        ),
      ),
      style = "text-align:justify"
    ),
    tags$p(
      "Before submitting your report or request, please search for \ 
      keywords to ensure that it has not already been reported.",
      style = "text-align:justify"
    ),
    tags$hr(),

    # Funding
    tags$h5(
      strong("Funding"),
      style = "text-align: center;"
    ),
    tags$br(),
    tags$p(
      "KVFinder-web software was supported by Fundação de Amparo à Pesquisa \ 
      do Estado de São Paulo (FAPESP) [Grant Number 2018/00629-0], Brazilian \ 
      Biosciences National Laboratory (LNBio) and Brazilian Center for \ 
      Research in Energy and Materials (CNPEM).",
      style = "text-align:justify"
    ),
    tags$hr(),

    # License
    tags$h5(
      strong("License"),
      style = "text-align: center;"
    ),
    tags$br(),
    tags$p(
      "The KVFinder-web software is licensed under the terms of the \ 
      Apache-2.0 License and is distributed in the hope that it will be \ 
      useful, but WITHOUT ANY WARRANTY; without even the implied warranty \ 
      of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the \ 
      Apache-2.0 License for more details.",
      style = "text-align:justify"
    )
  )

}
