#' KVserver User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyjs
#' @import bs4Dash
#' @import NGLVieweR
#' @import golem
#' @import shinycssloaders
#' @import shinyfullscreen
#' @noRd
#'

app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # ____________________________________________________________
    dashboardPage(
      # Header----------------------------------------------------
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
      # Sidebar--------------------------------------------------
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

        # sidebar menu
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
            "Tutorial",
            tabName = "tutorial_kv_sidebar",
            icon = icon("question-circle")
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
      # Control bar -----------------------------------------------
      controlbar = dashboardControlbar(
        disable = FALSE,
        width = 250,
        collapsed = TRUE,
        overlay = TRUE,
        skin = "dark",
        pinned = NULL
      ),

      # Footer-----------------------------------------------------
      # footer = dashboardFooter(right = ("Developed by LBC-LNBio")),


      # Dashboard body-----------------------------------------------
      body = dashboardBody(
        useShinyjs(),
        tabItems(
          # 1st tab: Run KVFinder-web
          tabItem(
            tabName = "run_kv_sidebar",
            # Create jumbotron
            create_jumbotron(),
            #-------------------------------------------
            # Choose input card
            fluidRow(column(
              12,
              choose_input()
            )),
            #------------------------------------------
            # Choose run mode card
            fluidRow(column(
              12,
              choose_run_mode(),
            )),
            #-------------------------------------------
            # Submit section
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
            # Result section
            fluidRow(
              column(
                5,
                uiOutput("output_status1"),
                tags$br(),
                fluidRow(
                  column(
                    4,
                    uiOutput("download")
                  ),
                  column(
                    4,
                    uiOutput("download2")
                  ),
                  column(
                    4,
                    uiOutput("view_output")
                  )
                ),
                tags$br(),
                uiOutput("results_table"),
                tags$br(),
              ),
              column(
                7,
                # function to fulscreen the entire div that contains the NGL viewer and all the othe buttons
                fullscreen_this(tags$div(
                  id = "view_panel",
                  fluidRow(
                    column(
                      12,
                      NGLVieweROutput("structure", width = "100%", height = "75vh")
                    )
                  ),
                  fluidRow(
                    column(3, uiOutput("selection_pdb")),
                    column(3, uiOutput("cavity_color")),
                    column(3, uiOutput("protein_rep")),
                    column(3, uiOutput("protein_color_scheme"))
                  ),
                  fluidRow(
                    column(3, uiOutput("show_interface")),
                    column(2, uiOutput("protein_color")),
                    column(3, uiOutput("bg_color")),
                    column(2, align = "center", uiOutput("snapshot_title"), uiOutput("snapshot")),
                    column(2, align = "center", uiOutput("fullscreen_title"), uiOutput("fullscreen"))
                  )
                ), click_id = "fullscreen")
              )
            )
          ),

          # 2nd tab: Get latest results
          tabItem(
            tabName = "check_kv_sidebar",
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
                  fluidRow(
                    column(
                      4,
                      uiOutput("download_pg2")
                    ),
                    column(
                      4,
                      uiOutput("download2_pg2")
                    ),
                    column(
                      4,
                      uiOutput(
                        "view_output_pg2"
                      )
                    )
                  ),
                  tags$br(),
                  uiOutput("results_table_pg2"),
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
                fullscreen_this(tags$div(
                  id = "view_panel_pg2",
                  fluidRow(
                    NGLVieweROutput("structure_pg2", width = "100%", height = "600px")
                  ),
                  fluidRow(
                    column(3, uiOutput("selection_pdb_pg2")),
                    column(3, uiOutput("cavity_color_pg2")),
                    column(3, uiOutput("protein_rep_pg2")),
                    column(3, uiOutput("protein_color_scheme_pg2")),
                  ),
                  fluidRow(
                    column(3, uiOutput("show_interface_pg2")),
                    column(2, uiOutput("protein_color_pg2")),
                    column(3, uiOutput("bg_color_pg2")),
                    column(2, align = "center", uiOutput("snapshot_title_pg2"), uiOutput("snapshot_pg2")),
                    column(2, align = "center", uiOutput("fullscreen_title_pg2"), uiOutput("fullscreen_pg2"))
                  )
                ), click_id = "fullscreen_pg2")
              )
            )
          ),

          # 3rd tab: Tutorial page
          tabItem(
            tabName = "tutorial_kv_sidebar",
            kv_tutorial()
          ),

          # 4th tab: Help page
          tabItem(
            tabName = "help_kv_sidebar",
            kv_help()
          ),

          # 5th tab: About page
          tabItem(
            tabName = "about_kv_sidebar",
            kv_about()
          )
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
#'
#'

golem_add_external_resources <- function() {
  add_resource_path("www", app_sys("app/www"))
  tags$head(
    tags$link(
      rel = "shortcut icon",
      href = "www/new_icon/kvfinder_favicon_v2.png"
    ),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "KVFinder-web"
    )
  )
}
