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
      column(12, align = "center", tags$h3("Tutorial"))
    ),
    tags$br(),
    tags$br(),
    tags$p("This section is an introductory overview of KVFinder-web service features. Here, we are going to demonstrate how to use this KVFinder-web interface with our publicly available KVFinder-web service (",
      tags$a(href = "https://kvfinder-web.cnpem.br", "kvfinder-web.cnpem.br"),
      ").",
      style = "text-align:justify"
    ),
    tags$p("In this tutorial, we will explore the four execution modes of KVFinder-web service to identify and spatially characterize cavities, and retrieve a job from the web service via its ID."),
    tags$p(
      "All biomolecular structures used in this tutorial are accessible via their PDB ID. The structures are:",
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
      style = "text-align:justify"
    ),

    ## Cavity analysis
    tags$h5(strong("Cavity Analysis")),
    ### Step 1. Load biomolecular structure from PDB
    tags$p(
      "First of all, you must open ",
      strong("Run KVFinder"),
      " tab to start your cavity analysis pipeline.",
      style = "text-align:justify"
    ),
    tags$p(
      "After, you must load a target biomolecular structure into the ",
      strong("Step 1. Choose input"),
      ". For example, you could load human PPAR-gamma (1PRG) into KVFinder-web interface.",
      "The ",
      strong("Type of input"),
      "must be set to 'Fetch from PDB'. Then, you must type '1PRG' in the ",
      strong("PDB ID"),
      "text box. Finally, click on ",
      strong("Load"),
      "button."
    ),
    tags$br(),
    fluidRow(
      column(12, align = "center", tags$img(src = "www/tutorial-step1-load-1PRG.png", align = "center")),
    ),
    tags$br(),
    tags$p(
      "Upon successfully loading the structure from PDB database, an option to keep non-standard residues (e.g., water, ligands, ions, etc) will appear in the screen. For 1PRG, we do not want to keep water molecules for further analysis. So, we do not check 'HOH' checkbox."
    ),
    tags$br(),
    fluidRow(
      column(12, align = "center", tags$img(src = "www/tutorial-step1-include-non-standard-residues-1PRG.png", align = "center")),
    ),
    tags$br(),

    ### Step 2. Run Cavity Analysis
    tags$p(
      "Now, we can explore the four different execution modes, that are:",
      style = "text-align:justify"
    ),
    tags$ol(
      #### Whole protein (default)
      tags$li(strong("Whole structure with default parameters")),
      tags$p(
        "Here, you must select 'Whole structure (default)' into the ",
        strong("Step 2. Choose run mode"),
        ". The default parameters are designed to make a simple and fast whole structure detection."
      ),
      tags$br(),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step2-wp-mode1.png", align = "center")),
      ),
      tags$br(),

      ##### Submission
      tags$p(
        "To submit any job to KVFinder-web service, just click on ",
        strong("Submit the job"),
        "button."
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step2-wp-mode1-submit.png", align = "center")),
      ),
      tags$br(),

      ##### Check results
      tags$p(
        "After successfully submitting the job to KVFinder-web service, a window will appear with the",
        strong("Job ID"),
        ". For instace, the Job ID of our submission is",
        em("6524504029010759880"),
        ". To check of you submission, click on ",
        strong("Check Results"),
        "button."
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step2-wp-mode1-info.png", align = "center")),
      ),

      ##### Job status
      tags$p(
        "After completion, the ",
        strong("Status"),
        "field will change to",
        strong("completed"),
        "and turn green. Then, three button and a table with cavity names, volumes and areas will appear on the screen."
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode1-check-results.png", align = "center")),
      ),
      tags$p("These three buttons are:",
        tags$ol(
          ###### 1
          tags$li(
            strong("Download cavities:"),
            "Download a PDB-formatted file with the detected cavities;"
          ),
          fluidRow(
            column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode1-pdb.png", align = "center")),
          ),
          tags$br(),

          ###### 2
          tags$li(
            strong("Download Results:"),
            "Download a TOML-formatted file with characterizations (volume, area and surrounding residues) of the detected cavities and the detection parameters used in the cavity analysis;"
          ),
          fluidRow(
            column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode1-toml.png", align = "center")),
          ),
          tags$br(),

          ###### 3
          tags$li(
            strong("View:"),
            "Enable a interactive window to visualize the cavities with the target biomolecular structure."
          ),
          fluidRow(
            column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode1-view.png", align = "center")),
          ),
          tags$br()
        ),
        style = "text-align:justify"
      ),
      tags$p(
        "Furthermore, we can select a specific cavity to visualize in the interactive window. For instance, we select 'KAC' in the",
        strong("Show cavity"),
        "drop menu."
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode1-view2.png", align = "center")),
      ),
      tags$p(
        "Still, we can show the residues surrounding the selected cavities by clicking on",
        strong("Show interface residues"),
        "checkbutton."
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode1-view3.png", align = "center")),
      ),
      tags$br(),
      tags$hr(),

      #### Whole protein (customized)
      tags$li(strong("Whole structure with customized parameters")),
      tags$p(
        "Here, you must select 'Whole structure (customized)' into the ",
        strong("Step 2. Choose run mode"),
        "."
      ),
      tags$p(
        "KVFinder-web service is all about parameters customization of parKVFinder software. The detection parameters and their impact on cavity detection are explained in details in the",
        strong("Help"),
        " tab. In summary, 'Probe In' defines the inner limits of the cavities, 'Probe Out' defines outer limits of the cavities, 'Removal Distance' defines the length to be remove from the cavity-bulk boundary and 'Volume Cutoff' excludes cavities with volumes smaller than this limit. Let's show the effect of varying 'Volume Cutoff', 'Probe Out' and 'Removal Distance'."
      ),
      tags$br(),
      tags$ul(
        ##### Adjusting Volume Cutoff
        tags$li(strong("Adjusting Volume Cutoff:"), "the Volume Cutoff limits the smaller cavity that would be identified. So, we set Volume Cutoff to 500 Å³. Them, we submit the job to KVFinder-web service again."),
        tags$p(
          "After completion, display the job results by clicking on ",
          strong("View"), "button."
        ),
        fluidRow(
          column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode2-vc500.png", align = "center")),
        ),
        tags$br(),
        tags$p("With a greater Volume Cutoff, we identified less cavities compared to the detection with default parameters."),
        tags$br(),

        ##### Adjusting Probe Out
        tags$li(strong("Adjusting Probe Out:"), "the Probe Out size changes the level of the cavity boundary. So, we set Probe Out to 8.0 Å and keep Volume Cutoff to 500 Å³. Then, we submit the job to KVFinder-web service again."),
        tags$p(
          "After completion, display the job results by clicking on ",
          strong("View"), "button."
        ),
        fluidRow(
          column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode2-po8-vc500.png", align = "center")),
        ),
        tags$br(),
        tags$p("With a larger Probe Out, the detected cavities has a higher boundary than that detected with the 4.0 Å probe. Therefore, by increasing the size of the Probe Out, the cavity boundary is also raised."),
        tags$br(),

        ##### Adjusting Removal Distance
        tags$li(strong("Adjusting Removal Distance:"), "Besides adjusting the Probe Out size, we can also adjust the Removal Distance to change the cavity boundary. So, we set Removal Distance to 1.2 Å and the size of Probe Out back to 4.0 Å let's go back to the Main tab and change the Removal Distance to 1.2 Å, the size of Probe Out back to 4.0 Å and still keep Volume Cutoff to 500 Å³. Then, we submit the job to KVFinder-web service again."),
        tags$p(
          "After completion, display the job results by clicking on ",
          strong("View"), "button."
        ),
        fluidRow(
          column(12, align = "center", tags$img(src = "www/tutorial-step3-wp-mode2-rd12-vc500.png", align = "center")),
        ),
        tags$br(),
        tags$p("With a smaller Removal Distance, the detected cavities has a higher boundary than that detected with the 2.4 Å. Therefore, by decreasing the Removal Distance, the cavity boundary is also raised."),
        tags$p("Therefore, changing the cavity boundary by varying Probe Out and Removal Distance also affects cavity segregation."),
        tags$br(),
      ),
      tags$br(),
      tags$hr(),

      #### Steered detection
      tags$p(
        "Another important feature of parKVFinder is the steered detection of cavities. Here, instead of analyzing the PPAR-gamma structure, we are analyzing HIV-1 protease (PDB ID: 1HVR). First, we have to replicate",
        strong("Step 1"),
        "by replacing '1PRG' for '1HVR' and click on ",
        strong("Load"),
        "button again."
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step1-load-1HVR.png", align = "center")),
      ),
      tags$br(),
      tags$p("Upon successfully loading the structure from PDB database, we do not want to keep HIV-1 protease inhibitor, XK2 molecule, for further analysis. So, we do not check 'XK2' checkbox."),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step1-include-non-standard-residues-1HVR.png", align = "center")),
      ),
      tags$br(),
      tags$p("Then, we continue our tutorial by illustrating two distinct methods of cavity segmentation:"),

      #### Around target molecule
      tags$li(strong("Around target molecules")),
      tags$p("Here, we can limit the search around a structure. Let's detect the cavities of HIV-1 protease, but limiting the search space around its inhibitor."),

      ##### Selecting target molecule
      tags$p(
        "For that, you must select 'Around target molecule' into the ",
        strong("Step 2. Choose run mode"),
        ". After, you must select 'XK2' option in the ",
        strong("Ligand or molecule name"),
        "selection box. Then, we submit the job to KVFinder-web service again."
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step2-la-mode3.png", align = "center")),
      ),

      ##### Visualiazing results
      tags$p(
        "After completion, display the job results by clicking on ",
        strong("View"), "button."
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
        "Here, we can limit the search around a closed region with a custom box, which is drawn based on a selection of residues and a padding. Let's detect again the cavities of HIV-1 protease, but limiting the search space around the residues",
        em("27_A;27_B;34_A;34_B;51_A;51_B;"),
        "and setting the padding to 0.5 Å. Then, we submit the job to KVFinder-web service again."
      ),
      fluidRow(
        column(12, align = "center", tags$img(src = "www/tutorial-step2-ba-mode4.png", align = "center")),
      ),

      ##### Visualiazing results
      tags$p(
        "After completion, display the job results by clicking on ",
        strong("View"), "button."
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
      "Users may submit a job that have already been submitted to the KVFinder-web service and the job is still available on the web service."
    ),
    tags$p(
      "In this scenario, the",
      strong("Status"),
      "field will already be shown as ",
      strong("completed")
    ),
    fluidRow(
      column(12, align = "center", tags$img(src = "www/tutorial-status-field-completed.png", align = "center")),
    ),
    tags$br(),
    tags$hr(),

    ## Retrieving a Job by its ID description
    tags$h5(strong("Retrieving a Job by its ID")),
    tags$p("Users may share their jobs with colleagues by the Job ID that they receive when submitting a job."),
    tags$p(
      "First, you must open ",
      strong("Get latest results"),
      ". After, you must fill a Job ID (e.g.,",
      em("6524504029010759880"),
      "- ID of our first job in this tutorial) in the ",
      strong("Insert the run ID to get results"),
      "text box and click on .",
      strong("Get results"),
      "button."
    ),
    fluidRow(
      column(12, align = "center", tags$img(src = "www/tutorial-retrieve-job.png", align = "center")),
    ),
    tags$br(),

    ### Job exist
    tags$p(
      "If the job was available in the KVFinder-web service, a field will appear with the Job ID Status. After completion, the",
      strong("Status"),
      "field will change to completed and turn green. Then, three button and a table with cavity names, volumes and areas will appear on the screen. Finally, we can display the job results by clicking on View button."
    ),
    fluidRow(
      column(12, align = "center", tags$img(src = "www/tutorial-retrieve-job-results.png", align = "center")),
    ),
    tags$br(),

    ### Job does not exist
    tags$p("Otherwise, the job does not exist or is not available in the KVFinder-web service anymore. In both situation, a error message will appear in the Job status field."),
    fluidRow(
      column(12, align = "center", tags$img(src = "www/tutorial-retrieve-job-bad-id.png", align = "center")),
    ),
    tags$br(),
    tags$hr(),
  )
}
