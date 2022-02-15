#' KVserver User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyjs
#' @import bs4Dash
#' @import NGLVieweR
#' @noRd
#' 


app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    
    #____________________________________________________________
    dashboardPage(
      #Header----------------------------------------------------
      header = dashboardHeader(
        title = "KVFinder-web service",
        titleWidth = NULL,
        disable = FALSE,
        .list = NULL,
        skin = "light",
        status = "white",
        border = TRUE,
        compact = FALSE,
        sidebarIcon = shiny::icon("bars"),
        controlbarIcon = shiny::icon("th"),
        fixed = FALSE,
        leftUi = NULL,
        rightUi = NULL
      ),
      #Sidebar--------------------------------------------------
      sidebar = dashboardSidebar(
        disable = FALSE,
        width = NULL,
        skin = "dark",
        status = "primary",
        elevation = 4,
        collapsed = FALSE,
        minified = TRUE,
        expandOnHover = TRUE,
        fixed = TRUE,
        id = "sidebar",
        customArea = NULL,
        
        #sidebar menu
        sidebarMenu(
          id = "sidebarmenu",
          menuItem(
            "Run KVFinder",
            tabName = "run_kv_sidebar",
            icon = icon("angle-double-right")
          ),
          menuItem(
            "Get lastest results",
            tabName = "check_kv_sidebar",
            icon = icon("angle-double-right")
          ),
          menuItem(
            "Help",
            tabName = "help_kv_sidebar",
            icon = icon("question-circle")
          ),
          menuItem(
            "About",
            tabName = "about_kv_sidebar",
            icon = icon("info-circle")
          )
        )
      ),
      #Control bar -----------------------------------------------
      controlbar = dashboardControlbar(
        disable = FALSE,
        width = 250,
        collapsed = TRUE,
        overlay = TRUE,
        skin = "dark",
        pinned = NULL
      ),
      
      #Footer-----------------------------------------------------
      footer = dashboardFooter(right = ("Developed by...")),
      
      
      #Dashboard body-----------------------------------------------
      body = dashboardBody(
        useShinyjs(),
        
        tabItems(
          #1st tab -> Run KVFinder
          tabItem(
            tabName = "run_kv_sidebar",
            #Create jumbotron
            create_jumbotron(),
            #-------------------------------------------
            #Choose run mode card
            fluidRow(column(12,
                            choose_run_mode(),)),
            #------------------------------------------
            #Choose input card
            fluidRow(column(12,
                            choose_input())),
            #-------------------------------------------
            #Submit section
            column(
              12,
              align = "center",
              actionButton(
                "submit_button",
                "Submit the job",
                icon = icon("arrow-circle-right"),
                gradient = FALSE,
                outline = FALSE,
                size = "lg",
                flat = TRUE
              ),
              htmlOutput("run_id"),
              uiOutput("check_results_submit")
            ),
            tags$br(),
            #--------------------------------------------
            #Result section
            fluidRow(
              column(
                5,
                uiOutput("output_status1"),
                tags$br(),
                fluidRow(column(8,
                                uiOutput("download")),
                         column(4,
                                uiOutput("view_output"))),
                tags$br(),
                uiOutput('results_table'),
                tags$br(),
              ),
              column(
                7,
                fluidRow(NGLVieweROutput(
                  "structure", width = "100%", height = "400px"
                )),
                fluidRow(
                  column(3, uiOutput("selection_pdb")),
                  column(3, uiOutput("cavity_color")),
                  column(3, uiOutput("protein_rep")),
                  column(3, uiOutput("protein_color"))
                ),
                fluidRow(
                  column(7, uiOutput("show_interface")),
                  column(3, uiOutput("bg_color")),
                  column(2, align = "center", uiOutput("snapshot_title"), uiOutput("snapshot"))
                )
              )
            )
          ),
          
          #2nd tab -> Get latest results
          tabItem(tabName = "check_kv_sidebar",
                  fluidRow(
                    column(
                      5,
                      bs4Card(
                        title = "Get latest results",
                        id = "check_results_box",
                        collapsible = TRUE,
                        collapsed = FALSE,
                        closable = FALSE,
                        solidHeader = TRUE,
                        elevation = 2,
                        headerBorder = TRUE,
                        width = 11,
                        textInput(
                          inputId = "insert_ID",
                          label = "Insert the run ID to get results",
                          placeholder = "ID number"
                        ),
                        actionButton(
                          inputId = "check_loc_pg2",
                          label = "Get results",
                          icon = icon("share-square")
                        ),
                        tags$br(),
                        tags$br(),
                        uiOutput("output_status_pg2"),
                        fluidRow(column(8,
                                        uiOutput("download_pg2")),
                                 column(4,
                                        uiOutput(
                                          "view_output_pg2"
                                        ))),
                        tags$br(),
                        uiOutput('results_table_pg2'),
                        tags$br(),
                        sidebar = boxSidebar(
                          id = "help_get_results_pg2",
                          icon = icon("info"),
                          p("Here, you can insert a run ID to get or check your latest results.")
                        )
                      )
                    ),
                    column(
                      7,
                      fluidRow(
                        NGLVieweROutput("structure_pg2", width = "100%", height = "400px")
                      ),
                      fluidRow(
                        column(3, uiOutput("selection_pdb_pg2")),
                        column(3, uiOutput("cavity_color_pg2")),
                        column(3, uiOutput("protein_rep_pg2")),
                        column(3, uiOutput("protein_color_pg2"))
                      ),
                      fluidRow(
                        column(7, uiOutput("show_interface_pg2")),
                        column(3, uiOutput("bg_color_pg2")),
                        column(
                          2,
                          align = "center",
                          uiOutput("snapshot_title_pg2"),
                          uiOutput("snapshot_pg2")
                        )
                      )
                    )
                  )),
          
          #3th tab -> Help page
          tabItem(tabName = "help_kv_sidebar",
                  kv_help()),
          
          #4th tab -> About page
          tabItem(tabName = "about_kv_sidebar",
                  kv_about())
          
        )
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path('www', app_sys('app/www'))
  
  tags$head(favicon(),
            bundle_resources(path = app_sys('app/www'),
                             app_title = 'KVserver'))
  # Add here other external resources
  # for example, you can add shinyalert::useShinyalert() )
}

