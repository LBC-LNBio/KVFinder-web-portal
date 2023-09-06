#' Function that creates the jumbotron of the main Run KVFinder page
#'
#' @import shiny
#'

jumbotron <- function() {
  
  jumb <-
    tags$div(
      class = "jumbotron bg-primary",
      style = "padding: 1rem 2rem; background-color: #578dca !important;",
      tags$h1(
        class = "display-7",
        "Welcome to KVFinder-web!",
        style = "margin-top: 0.5rem; margin-bottom: 1rem; text-align: center;"
      ),
      tags$img(
        class = "col-sm-8",
        src = "www/cover.png",
        style="display: block; margin-left: auto; margin-right: auto; max-width: 1200px;"
      ),
      tags$h5(
        "A web application for cavity detection and characterization in any type of biomolecular structure.",
        tags$button(
          class = "btn btn-default action-button",
          id = "more_button",
          type = "button",
          "More",
          style = "background-color: #6c757d; color: white; margin: 0.5rem;"
        ),
        style = "margin: 1rem; text-align: center;",
      ),
      tags$hr(style="margin: 0rem;"),
    )

  return(jumb)

}
