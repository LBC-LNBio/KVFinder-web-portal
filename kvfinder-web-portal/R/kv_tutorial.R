#' Function that creates the tutorial page of the KVFinder server
#'
#' @import shiny
#'
#' @export
#'

kv_tutorial <- function() {

  fluidPage(

    # Tutorial topic
    tags$h2(
      tags$strong("Tutorial"),
      style = "text-align:center",
    ),
    tags$br(),
    tags$p(
      "Welcome to the KVFinder-web tutorial! This section provides an \ 
      overview of the features available through our publicly available \ 
      KVFinder-web service at ",
      tags$a(
        href = "https://kvfinder-web.cnpem.br",
        "kvfinder-web.cnpem.br",
        target = "_blank"
      ),
      ".",
      style = "text-align:justify"
    ),
    tags$p("In this tutorial, we will guide you through the four execution \ 
    modes of KVFinder-web, allowing you to identify and characterize cavities \ 
    in biomolecular structures. We will also explain how to retrieve results \ 
    using job IDs."),
    tags$p(
      "For this tutorial, we will use two biomolecular structures identified \ 
      by their PDB IDs:",
      tags$ul(
        tags$li(
          "Human Peroxisome Proliferator Activated Receptor Gamma (",
          tags$a(
            href = "https://www.rcsb.org/structure/1PRG",
            "1PRG",
            target = "_blank"
          ),
          ");"
        ),
        tags$li(
          "HIV-1 Protease (",
          tags$a(
            href = "https://www.rcsb.org/structure/1HVR",
            "1HVR",
            target = "_blank"
          ),
          ")"
        ),
      ),
      "By the end of this tutorial, you should have a clear understanding of \ 
      how to employ KVFinder-web for cavity detection and characterization in \ 
      your own biomolecular structures.",
      style = "text-align:justify"
    ),
    tags$hr(),

    ## Cavity analysis
    tags$h4(
      tags$strong("Cavity Analysis"),
      style = "text-align:center"
    ),
    tags$br(),

    ### Step 1. Load biomolecular structure from PDB
    tags$p(
      "To start your cavity analysis, go to the ",
      tags$strong("Run Cavity Analysis"),
      " tab.",
      style = "text-align:justify"
    ),
    tags$p(
      "Next, load your target biomolecular structure in ",
      tags$strong("Step 1. Choose Input"),
      " by selecting ",
      tags$strong("Fetch from PDB"),
      " as the input type and entering the PDB ID in the text box.",
      "For instance, to analyze the human Peroxisome Proliferator Activated \ 
      Receptor Gamma (1PRG), enter ",
      tags$strong("1PRG"),
      " and click ",
      tags$strong("Load"),
      ".",
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-step1-load-1PRG.png",
        style = "width: 100%; max-width: 730px;"
      ),
      style = "display: flex; justify-content: center;"
    ),
    tags$p(
      "Once the structure is loaded, you will have the option to keep \ 
      non-standard residues, such as water, ligands, and ions.",
      style = "text-align:justify"
    ),
    tags$p(
      "In the case of the 1PRG example, we do not want to include water \ 
      molecules in further analysis, so please leave the ",
      tags$strong("HOH"),
      " checkbox unchecked.",
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-step1-include-non-standard-residues-1PRG.png",
        style = "width: 100%; max-width: 730px;"
      ),
      style = "display: flex; justify-content: center;"
    ),

    ### Step 2. Run Cavity Analysis
    tags$p(
      "Now, let us explore the four different execution modes, that are:",
      style = "text-align:justify"
    ),
    tags$ol(
      tags$li("Whole structure (default)"),
      tags$li("Whole structure (customized)"),
      tags$li("Around target molecule"),
      tags$li("Around target residues"),
      style = "text-align:justify"
    ),
    tags$br(),

    # Mode 1. Whole protein (default)
    tags$h5(
      tags$strong("1. Whole structure analysis with default parameters"),
      style = "text-align:center"
    ),
    tags$p(
      "This mode is designed for a quick and straighforward cavity detection \ 
      across the whole structure. To use it, select ",
      tags$strong("Whole structure (default)"),
      " in ",
      tags$strong("Step 2. Choose run mode"),
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-step2-wp-mode1.png",
        style = "width: 100%; max-width: 730px;"
      ),
      style = "display: flex; justify-content: center;"
    ),

    ## Submission
    tags$p(
      "To submit a job for cavity analysis, simply click the ",
      tags$strong("Submit the job"),
      " button.",
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-step2-wp-mode1-submit.png",
        style = "width: 100%; max-width: 730px;"
      ),
      style = "display: flex; justify-content: center;"
    ),

    ## Job Information
    tags$p(
      "Upon successfully submitting the job to the KVFinder-web service, a \ 
      window will display your ",
      tags$strong("Job ID"),
      ". For example, the Job ID for our submission is ",
      tags$strong("12727934810399286938"),
      ". To check your submission, click the ",
      tags$strong("Check Results"),
      " button."
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-step2-wp-mode1-info.png",
        style = "width: 100%; max-width: 830px;"
      ),
      style = "display: flex; justify-content: center;"
    ),

    ## Job status
    tags$p(
      "Once the analysis is complete, the ",
      tags$strong("Status"),
      " field will switch to ",
      tags$strong("completed"),
      " and turn green, indicating that the job has finished processing. \ 
      You will then see the following three buttons along with a table \ 
      displaying cavity characterizations:",
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-step3-wp-mode1-check-results.png",
        style = "width: 100%; max-width: 960px;"
        ),
      style = "display: flex; justify-content: center;"
    ),

    ## Job results
    tags$ul(
      tags$li(
        tags$strong("Download Structures:"),
        " This option allows you to download a ZIP file containing \ 
        PDB-formatted files of the input and the cavities."
      ),
      tags$p(
        tags$img(
          src = "www/tutorial-step3-wp-mode1-pdb.png",
          style = "width: 100%; max-width: 490px;"
          ),
        style = "display: flex; justify-content: center;"
      ),
      tags$li(
        tags$strong("Download Results:"),
        " You can obtain a TOML-formatted file containing characterizations \ 
        (volume, area, average depth, maximum depth, average hydropathy, and \ 
        interface residues surrounding the cavities) of the detected cavities \ 
        and the parameters used in the cavity analysis. A detailed \ 
        description of the TOML-formatted file is available in the ",
        tags$strong("Help"),
        " tab."
      ),
      tags$p(
        tags$img(
          src = "www/tutorial-step3-wp-mode1-toml.png",
          style = "width: 100%; max-width: 490px;"
        ),
        style = "display: flex; justify-content: center;"
      ),
      tags$p("
      Additionally, you can download characterizations in Excel and PDF \ 
      format by clicking on the ",
      tags$strong("Excel"),
      " and ",
      tags$strong("PDF"),
      "buttons in the DataTable toolbar, respectively.",
      ),
      tags$p(
        tags$img(
          src = "www/tutorial-step3-wp-mode1-excel.png",
          style = "width: 100%; max-width: 490px;"
        ),
        style = "display: flex; justify-content: center;"
      ),
      tags$p(
        tags$img(
          src = "www/tutorial-step3-wp-mode1-pdf.png",
          style = "width: 100%; max-width: 490px;"
        ),
        style = "display: flex; justify-content: center;"
      ),
      tags$li(
        tags$strong("View:"),
        " Activate an interactive window for visualizing the cavities within \ 
        the target biomolecular structure."
      ),
      tags$p(
          tags$img(
            src = "www/tutorial-step3-wp-mode1-view.png",
            style = "width: 100%; max-width: 1200px;"
            ),
          style = "display: flex; justify-content: center;"
      ),
      tags$p(
        "Furthermore, you can select a specific cavity for visualization in \ 
        the interactive window by clicking on its corresponding name in the ",
        tags$strong("Select cavity"),
        " drop-down menu. For example, we have selected ",
        tags$strong("KAC"),
        " from the ",
        tags$strong("Select cavity"),
        " drop-down menu."
      ),
      tags$p(
          tags$img(
            src = "www/tutorial-step3-wp-mode1-view2.png",
            style = "width: 100%; max-width: 1200px;"
            ),
          style = "display: flex; justify-content: center;"
      ),
      tags$p(
        "You can also display the interface residues surrounding the selected \ 
        cavities by clicking on the ",
        tags$strong("Interface AA"),
        " checkbox."
      ),
      tags$p(
          tags$img(
            src = "www/tutorial-step3-wp-mode1-view3.png",
            style = "width: 100%; max-width: 1200px;"
          ),
          style = "display: flex; justify-content: center;"
      ),
      tags$p(
        "Lastly, you can either display the depth or hydropathy by clicking \ 
        on the ",
        tags$strong("Depth"),
        " or ",
        tags$strong("Hydropathy"),
        " checkbox, respectively. However, only one of them can be displayed \ 
        at a time, while you can combine either with interface residue \ 
        visualization."
      ),
      tags$p(
          tags$img(
            src = "www/tutorial-step3-wp-mode1-view4.png",
            style = "width: 100%; max-width: 1200px;"
            ),
          style = "display: flex; justify-content: center;"
      ),
      tags$p(
          tags$img(
            src = "www/tutorial-step3-wp-mode1-view5.png",
            style = "width: 100%; max-width: 1200px;"
            ),
          style = "display: flex; justify-content: center;"
      ),
    ),
    tags$br(),

    # Mode 2. Whole protein (customized)
    tags$h5(
      tags$strong("2. Whole structure analysis with customized parameters"),
      style = "text-align: center"
    ),
    tags$p(
      "To use customized parameters, select ",
      tags$strong("Whole structure (customized)"),
      " in ",
      tags$strong("Step 2. Choose run mode"),
      ".",
      style = "text-align:justify",
    ),
    tags$p(
      "KVFinder-web empowers users to customize detection parameters for the \ 
      parKVFinder software (v1.2.0). Detailed explanations of these \ 
      parameters and their impact on cavity detection can be found in the ",
      tags$strong("Help"),
      " tab. In summary:",
      style = "text-align:justify",
    ),
    tags$ul(
      tags$li(
        tags$strong("Probe In:"),
        " defines the biomolecular surface, i.e., the inner limits of cavities;"
      ),
      tags$li(
        tags$strong("Probe Out:"),
        " defines the outer limits of cavities;"
      ),
      tags$li(
        tags$strong("Removal Distance:"),
        " specifies the length to be removed from the cavity-bulk boundary;"
      ),
      tags$li(
        tags$strong("Volume Cutoff:"),
        " excludes cavities with volumes smaller than the specified limit."
      ),
      style = "text-align:justify",
    ),
    tags$p(
      "To illustrate the effect of changing these parameters, let us \ 
      experiment with",
      tags$strong("Volume Cutoff"),
      ", ",
      tags$strong("Probe Out"),
      ", and",
      tags$strong("Removal Distance"),
      ":",
      style = "text-align:justify",
    ),
    tags$ul(
      ## Adjusting Volume Cutoff
      tags$li(
        tags$strong("Adjusting Volume Cutoff:"),
        " Setting ",
        tags$strong("Volume Cutoff"),
        " to 500 Å³ excludes smaller cavities are excluded from detection. \ 
        After submitting the job and viewing the results using the ",
        tags$strong("View"),
        " button, we can see that fewer cavities are identified compared to \ 
        the detection with default parameters."
      ),
      tags$p(
        tags$img(
          src = "www/tutorial-step3-wp-mode2-vc500.png",
          style = "width: 100%; max-width: 1200px;"
        ),
        style = "display: flex; justify-content: center;"
      ),
      ## Adjusting Probe Out
      tags$li(
        tags$strong("Adjusting Probe Out:"),
        " Increasing the ",
        tags$strong("Probe Out"),
        " size to 8.0 Å while keeping ",
        tags$strong("Volume Cutoff"),
        " at 500 Å³ results in cavities with a higher boundary compared to \ 
        those detected with a 4.0 Å probe. Therefore, by increasing the size \ 
        of ",
        tags$strong("Probe Out"),
        ", the cavity-bulk boundary is also raised."
      ),
      tags$p(
        tags$img(
          src = "www/tutorial-step3-wp-mode2-po8-vc500.png",
          style = "width: 100%; max-width: 1200px;"
        ),
        style = "display: flex; justify-content: center;"
      ),
      ## Adjusting Removal Distance
      tags$li(
        tags$strong("Adjusting Removal Distance:"),
        " Apart from modyfing the ",
        tags$strong("Probe Out"),
        " size, we can also adjust the ",
        tags$strong("Removal Distance"),
        " to alter the cavity-bulk boundary. Setting ",
        tags$strong("Removal Distance"),
        " to 1.2 Å, with ",
        tags$strong("Probe Out"),
        " at 4.0 Å and ",
        tags$strong("Volume Cutoff"),
        " at 500 Å³, results in cavities with a higher boundary than those \ 
        detected with a 2.4 Å ",
        tags$strong("Removal Distance"),
        ". Therefore, reducing the ",
        tags$strong("Removal Distance"),
        " also raises the cavity-bulk boundary."
      ),
      tags$p(
        tags$img(
          src = "www/tutorial-step3-wp-mode2-rd12-vc500.png",
          style = "width: 100%; max-width: 1200px;"
        ),
        style = "display: flex; justify-content: center;"
      ),
      style = "text-align:justify",
    ),
    tags$p(
        "In conclusion, altering the cavity boundary by varying ",
        tags$strong("Probe Out"),
        " and ",
        tags$strong("Removal Distance"),
        " also influences cavity segregation.",
        style = "text-align:justify",
    ),
    tags$br(),

    # Steered detection
    tags$h4(
      tags$strong("Steered Detection"),
      style = "text-align:center"
    ),
    tags$p(
      "Another significant feature of parKVFinder is the ability to steer the \ 
      detection of cavities. To demonstrate this, we will analyze the HIV-1 \ 
      protease structure (PDB ID: 1HVR) instead of the PPAR-gamma structure \ 
      (PDB ID: 1PRG). To do this, replace ",
      tags$strong("1PRG"),
      " with ",
      tags$strong("1HVR"),
      " in ",
      tags$strong("Step 1. Choose input"),
      " and click the ",
      tags$strong("Load"),
      " button once more.",
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-step1-load-1HVR.png",
        style = "width: 100%; max-width: 730px;"
      ),
      style = "display: flex; justify-content: center;"
    ),
    tags$p(
      "Once the structure is successfully loaded, you can further refine \ 
      your analysis by excluding specific molecules, such as the HIV-1 \ 
      protease inhibitor XK2, by leaving the corresponding checkbox unchecked.",
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-step1-include-non-standard-residues-1HVR.png",
        style = "width: 100%; max-width: 730px;"
      ),
      style = "display: flex; justify-content: center;"
    ),
    tags$br(),

    # Mode 3. Around target molecule
    tags$h5(
      tags$strong("3. Around target molecule"),
      style = "text-align: center"
    ),
    tags$p(
      "In this section, we will explore a method of cavity segmentation that \ 
      limits the search around a specific structure. We will use this method \ 
      to detect the cavities of HIV-1 protease while focusing on its \ 
      inhibitor.",
      style = "text-align:justify"
    ),
    tags$p(
      "To begin, select ",
      tags$strong("Around target molecule"),
      " in ",
      tags$strong("Step 2. Choose run mode"),
      ". Next, select the ",
      tags$strong("XK2"),
      " option in the ",
      tags$strong("Ligand or molecule"),
      "selection box. Then, submit the job to the KVFinder-web service.",
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-step2-la-mode3.png",
        style = "width: 100%; max-width: 730px;"
      ),
      style = "display: flex; justify-content: center;"
    ),
    tags$p(
      "Once the job is completed, click on the ",
      tags$strong("View"),
      " button to display the job results.",
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-step3-la-mode3.png",
        style = "width: 100%; max-width: 1200px;"
      ),
      style = "display: flex; justify-content: center;"
    ),
    tags$br(),

    # Mode 4. Around target residues
    tags$h5(
      tags$strong("4. Around target residues"),
      style = "text-align: center"
    ),
    tags$p(
      "This method enables us to confine the search around a defined region \ 
      using a custom box created based on a selection of residues and a \ 
      specified padding. Let us detect cavities once more, but this \ 
      time restrict the search space to include residues ",
      tags$strong("27_A;27_B;34_A;34_B;51_A;51_B;"),
      " with a ",
      tags$strong("Padding"),
      " of 5.0 Å. Then, submit the job to KVFinder-web service.",
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-step2-ba-mode4.png",
        style = "width: 100%; max-width: 730px;"
      ),
      style = "display: flex; justify-content: center;"
    ),
    tags$p(
      "Once the job is completed, check the job results by clicking the ",
      tags$strong("View"),
      " button.",
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-step3-ba-mode4.png",
        style = "width: 100%; max-width: 1200px;"
      ),
      style = "display: flex; justify-content: center;"
    ),
    tags$hr(),

    ## Submitting an already sent job description
    tags$h4(
      tags$strong("Submitting an already sent job"),
      style = "text-align:center"
    ),
    tags$br(),
    tags$p(
      "When a job has been submitted to the KVFinder-web service and is still \ 
       available, the ",
       tags$strong("Status"),
       " field will already be shown as ",
       tags$strong("completed"),
       ".",
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-status-field-completed.png",
        style = "width: 100%; max-width: 390px;"
      ),
      style = "display: flex; justify-content: center;"
    ),
    tags$hr(),

    ## Retrieving a Job by its ID description
    tags$h4(
      tags$strong("Retrieving a Job by ID"),
      style = "text-align:center"
    ),
    tags$br(),

    tags$p(
      "Users can effortlessly share their job results with colleagues by \ 
      providing them with the job ID. To retrieve a job, go to the ",
      tags$strong("Retrieve results"),
      " tab and enter the Job ID in the ",
      tags$strong("Insert the job ID to get results"),
      " text box. Then, click the ",
      tags$strong("Get results"),
      " button. For instance, use ",
      tags$strong("12727934810399286938"),
      " (the ID of our first job in this tutorial).",
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-retrieve-job.png",
        style = "width: 100%; max-width: 400px;"
      ),
      style = "display: flex; justify-content: center;"
    ),

    ## Job exist
    tags$p(
      "If the job is still available on the KVFinder-web service, a field \ 
      will appear displaying the Job ID Status. Once the job is completed, \ 
      the ",
      tags$strong("Status"),
      " field will change to ",
      tags$strong("completed"),
      " and turn green. At this point, three buttons and a table displaying \ 
      cavity characterizations will appear on the screen. To view the job \ 
      results, simply click the ",
      tags$strong("View"),
      " button.",
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-retrieve-job-results.png",
        style = "width: 100%; max-width: 1200px;"
      ),
      style = "display: flex; justify-content: center;"
    ),

    ## Job does not exist
    tags$p(
      "If the job does not exist or is no longer available on the \ 
      KVFinder-web service, an error message will be displayed in the ",
      tags$strong("Status"),
      " field.",
      style = "text-align:justify"
    ),
    tags$p(
      tags$img(
        src = "www/tutorial-retrieve-job-bad-id.png",
        style = "width: 100%; max-width: 400px;"
      ),
      style = "display: flex; justify-content: center;"
    ),
    tags$hr(),

  )

}
