#' Function that creates the tutorial page of the KVFinder server
#'
#' @import shiny
#' @export
#'
#'

kv_tutorial <- function() {
  fluidPage(
    # Tutorial topic
    fluidRow(
      column(12, align = "center", tags$h3(strong("Tutorial")))
    ),
    tags$br(),
    tags$p("Welcome to the KVFinder-web tutorial! This section provides an overview of the features available through our publicly available KVFinder-web service at (",
      tags$a(href = "https://kvfinder-web.cnpem.br", "kvfinder-web.cnpem.br"),
      ").",
      style = "text-align:justify"
    ),
    tags$p("In this tutorial, we will guide you through the four execution modes of KVFinder-web, which enable you to identify and characterize cavities in biomolecular structures. We will also show you how to retrieve results using job IDs."),
    tags$p(
      "For this tutorial, we will be using two biomolecular structures accessible via their PDB IDs:",
      tags$ul(
        tags$li(
          "Human Peroxisome Proliferator Activated Receptor Gamma (",
          tags$a(href = "https://www.rcsb.org/structure/1PRG", "1PRG"),
          ");"
        ),
        tags$li(
          "HIV-1 Protease (",
          tags$a(href = "https://www.rcsb.org/structure/1HVR", "1HVR"),
          ")"
        ),
      ),
      "By the end of this tutorial, you should have a good understanding of how to use KVFinder-web for cavity detection and characterization in your own biomolecular structures.",
      style = "text-align:justify"
    ),

    ## Cavity analysis
    tags$h5(strong("Cavity Analysis")),
    ### Step 1. Load biomolecular structure from PDB
    tags$p(
      "To start your cavity analysis pipeline, open the \"Run Cavity Analysis\" tab.",
      style = "text-align:justify"
    ),
    tags$p(
      "Next, load your target biomolecular structure into \"Step 1. Choose Input\" by selecting \"Fetch from PDB\" as the input type and typing the PDB ID in the text box. For example, to analyze the human Peroxisome Proliferator Activated Receptor Gamma (1PRG), type \"1PRG\" and click \"Load\".",
      style = "text-align:justify"
    ),
    tags$br(),
    fluidRow(
      column(12, align = "center", tags$img(src = "www/tutorial-step1-load-1PRG.png", align = "center")),
    ),
    tags$br(),
    tags$p(
      "Once the structure is loaded, you will have the option to keep non-standard residues (such as water, ligands, ions, etc). For the 1PRG example, we do not want to keep water molecules for further analysis, so uncheck the \"HOH\" checkbox.",
      style = "text-align:justify"
    ),
    tags$br(),
    fluidRow(
      column(12, align = "center", tags$img(src = "www/tutorial-step1-include-non-standard-residues-1PRG.png", align = "center")),
    ),
    tags$br(),

    ### Step 2. Run Cavity Analysis
    tags$p(
      "Now, we can explore the four different execution modes, which are:",
      style = "text-align:justify"
    ),
    tags$ol(
      #### Whole protein (default)
      tags$li(strong("Whole structure with default parameters")),
      tags$p(
        "This mode is designed to make a simple and fast whole structure detection. To use it, select \"Whole structure (default)\" in the \"Step 2. Choose run mode\".",
        style = "text-align:justify"
      ),
      tags$br(),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step2-wp-mode1.png", align = "center")),
      ),
      tags$br(),

      ##### Submission
      tags$p(
        "To submit a job for cavity analysis, click on the \"Submit the job\" button.",
        style = "text-align:justify"
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step2-wp-mode1-submit.png", align = "center")),
      ),
      tags$br(),

      ##### Check results
      tags$p(
        "After successfully submitting the job to KVFinder-web service, a window will appear with the",
        strong("Job ID"),
        ". For instance, the Job ID of our submission is",
        em("12727934810399286938"),
        ". To check your submission, click on \"Check Results\" button.",
        style = "text-align:justify"
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step2-wp-mode1-info.png", align = "center")),
      ),

      ##### Job status
      tags$p(
        "After completion, the \"Status\" field will change to \"completed\" and turn green, indicating that the job has finished processing. Then, the following three buttons will appear, along with a table showing cavity characterizations:",
        style = "text-align:justify"
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode1-check-results.png", align = "center")),
      ),
      tags$p(
        tags$ul(
          ###### 1
          tags$li(
            strong("Download Structures:"),
            "Download a ZIP file with PDB-formatted files of the input and the cavities;"
          ),
          fluidRow(
            column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode1-pdb.png", align = "center")),
          ),
          tags$br(),

          ###### 2
          tags$li(
            strong("Download Results:"),
            "Download a TOML-formatted file with characterizations (volume, area, average depth, maximum depth, average hydropathy and surrounding residues) of the detected cavities and the parameters used in the cavity analysis;"
          ),
          fluidRow(
            column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode1-toml.png", align = "center")),
          ),
          tags$br(),

          ###### 3
          tags$li(
            strong("View:"),
            "Enable an interactive window to visualize the cavities with the target biomolecular structure."
          ),
          fluidRow(
            column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode1-view.png", align = "center")),
          ),
          tags$br()
        ),
        style = "text-align:justify"
      ),
      tags$p(
        "Additionally, you can select a specific cavity to visualize in the interactive window by clicking on the corresponding name in the \"Select cavity\" drop menu. For instance, we select 'KAC' in the \"Select cavity\" drop menu.",
        style = "text-align:justify"
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode1-view2.png", align = "center")),
      ),
      tags$p(
        "You can also show the residues surrounding the selected cavities by clicking on the \"Interface AA\" check button.",
        style = "text-align:justify"
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode1-view3.png", align = "center")),
      ),
      tags$br(),
      tags$hr(),

      #### Whole protein (customized)
      tags$li(strong("Whole structure with customized parameters")),
      tags$p(
        "To use customized parameters, select \"Whole structure (customized)\" in the \'Step 2. Choose run mode\".",
        style = "text-align:justify"
      ),
      tags$p(
        "The KVFinder-web service allows users to customize detection parameters for the parKVFinder software. The parameters and their impact on cavity detection are explained in detail in the \"Help\" tab. To summarize, 'Probe In' defines the inner limits of cavities, 'Probe Out' defines the outer limits of cavities, 'Removal Distance' defines the length to be removed from the cavity-bulk boundary, and 'Volume Cutoff' excludes cavities with volumes smaller than the limit.",
        style = "text-align:justify"
      ),
      tags$br(),
      tags$p("To demonstrate the effect of changing these parameters, let's vary \"Volume Cutoff\", \"Probe Out\", and \"Removal Distance\":"),
      tags$ul(
        ##### Adjusting Volume Cutoff
        tags$li(
          strong("Adjusting Volume Cutoff:"),
          "By setting \"Volume Cutoff\" to 500 Å³, smaller cavities are excluded from detection. After submitting the job and viewing the results using the \"View\" button, we can see that fewer cavities are identified compared to the detection with default parameters.",
          style = "text-align:justify"
        ),
        fluidRow(
          column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode2-vc500.png", align = "center")),
        ),
        tags$br(),

        ##### Adjusting Probe Out
        tags$li(
          strong("Adjusting Probe Out:"),
          "By increasing the \"Probe Out\" size to 8.0 Å and keeping \"Volume Cutoff\" at 500 Å³, the detected cavities have a higher boundary than those detected with a 4.0 Å probe. Therefore, by increasing the size of \"Probe Out\", the cavity boundary is also raised.",
          style = "text-align:justify"
        ),
        fluidRow(
          column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode2-po8-vc500.png", align = "center")),
        ),
        tags$br(),

        ##### Adjusting Removal Distance
        tags$li(
          strong("Adjusting Removal Distance:"),
          "Besides adjusting the \"Probe Out\" size, we can also adjust the \"Removal Distance\" to change the cavity boundary. By setting \"Removal Distance\" to 1.2 Å and keeping the size of \"Probe Out\" at 4.0 Å and \"Volume Cutoff\" at 500 Å³, the detected cavities have a higher boundary than those detected with a 2.4 Å \"Removal Distance\". Therefore, by decreasing the \"Removal Distance\", the cavity boundary is also raised.",
          style = "text-align:justify"
        ),
        fluidRow(
          column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode2-rd12-vc500.png", align = "center")),
        ),
        tags$p(
          "Therefore, changing the cavity boundary by varying \"Probe Out\" and \"Removal Distance\" also affects cavity segregation.",
          style = "text-align:justify"
        ),
        tags$br(),
      ),
      tags$br(),
      tags$hr(),

      #### Steered detection
      tags$p(
        "Steered detection of cavities is another important feature of parKVFinder. To demonstrate this, we can analyze the HIV-1 protease structure (PDB ID: 1HVR) instead of the PPAR-gamma structure (PDB ID: 1PRG). To do this, we simply replace \"1PRG\" with \"1HVR\" in \"Step 1\" and click the \"Load\" button again.",
        style = "text-align:justify"
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step1-load-1HVR.png", align = "center")),
      ),
      tags$br(),
      tags$p(
        "Upon successfully loading the structure, we can also exclude specific molecules, such as the HIV-1 protease inhibitor XK2, by not checking the corresponding checkbox.",
        style = "text-align:justify"
      ),
      fluidRow(
        column(
          12,
          align = "center", tags$img(src = "www/tutorial-step1-include-non-standard-residues-1HVR.png", align = "center")
        ),
      ),
      tags$br(),
      tags$p(
        "Then, we continue our tutorial by illustrating two distinct methods of cavity segmentation:",
        style = "text-align:justify"
      ),

      #### Around target molecule
      tags$li(strong("Around target molecules")),
      tags$p(
        "In this section, we will explore a method of cavity segmentation that limits the search around a specific structure. We will use this method to detect the cavities of HIV-1 protease while focusing on its inhibitor.",
        style = "text-align:justify"
      ),

      ##### Selecting target molecule
      tags$p(
        "To begin, select \"Around target molecule\" in \"Step 2. Choose run mode\". Next, select the \"XK2\" option in the Ligand or molecule name selection box. Then, submit the job to the KVFinder-web service.",
        style = "text-align:justify"
      ),
      fluidRow(
        column(
          12,
          align = "center", tags$img(src = "www/tutorial-step2-la-mode3.png", align = "center")
        ),
      ),

      ##### Visualiazing results
      tags$p(
        "Once the job is completed, click on the \"View\" button to display the job results.",
        style = "text-align:justify"
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step3-la-mode3.png", align = "center")),
      ),
      tags$br(),
      tags$hr(),

      #### Around target residues
      tags$li(strong("Around target residues")),

      ##### Selecting target residues
      tags$p(
        "This method allows us to limit the search around a closed region with a custom box, which is drawn based on a selection of residues and a padding. Let's detect the cavities of HIV-1 protease again, but this time limit the search space around residues \"27_A; 27_B; 34_A; 34_B; 51_A; and 51_B;\" and set the padding to 0.5 Å. Then, submit the job to KVFinder-web service.",
        style = "text-align:justify"
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step2-ba-mode4.png", align = "center")),
      ),

      ##### Visualiazing results
      tags$p(
        "Once the job is completed, view the job results by clicking on the \"View\" button.",
        style = "text-align:justify"
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step3-ba-mode4.png", align = "center")),
      ),
      tags$br(),
      tags$hr(),
    ),

    ## Submitting an already sent job description
    tags$h5(strong("Submitting an already sent job")),
    tags$p(
      "When a job has already been submitted to the KVFinder-web service and is still available, the \"Status\" field will already be shown as \"completed\".",
      style = "text-align:justify"
    ),
    fluidRow(
      column(12, align = "center", tags$img(src = "www/tutorial-status-field-completed.png", align = "center")),
    ),
    tags$br(),
    tags$hr(),

    ## Retrieving a Job by its ID description
    tags$h5(strong("Retrieving a Job by ID")),
    tags$p("Users can easily share their job results with colleagues by providing them with the job ID. To retrieve a job, navigate to the \"Retrieve results\" page and enter the job ID in the \"Insert the job ID to get results\" text box. Then click on the \"Get results\" button. For instace, \"12727934810399286938\" (ID of our first job in this tutorial)"),
    fluidRow(
      column(12, align = "center", tags$img(src = "www/tutorial-retrieve-job.png", align = "center")),
    ),
    tags$br(),

    ### Job exist
    tags$p(
      "If the job is still available on the KVFinder-web service, a field will appear with the Job ID Status. After the job is completed, the \"Status\" field will change to \"completed\" and turn green. At this point, three buttons and a table displaying cavity characterizations will appear on the screen. To view the job results, simply click on the \"View\" button.",
      style = "text-align:justify"
    ),
    fluidRow(
      column(12, align = "center", tags$img(src = "www/tutorial-retrieve-job-results.png", align = "center")),
    ),
    tags$br(),

    ### Job does not exist
    tags$p(
      "If the job does not exist or is no longer available on the KVFinder-web service, an error message will appear in the \"Status\" field.",
      style = "text-align:justify"
    ),
    fluidRow(
      column(12, align = "center", tags$img(src = "www/tutorial-retrieve-job-bad-id.png", align = "center")),
    ),
    tags$br(),
    tags$hr(),
  )
}
