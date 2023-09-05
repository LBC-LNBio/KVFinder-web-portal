#' Function that creates the jumbotron of the main Run KVFinder page
#'
#' @import shiny
#'

create_jumbotron <- function() {
  jumb <-
    tags$div(
      class = "jumbotron bg-primary",
      style = "padding: 1rem 2rem; background-color: #578dca !important;",
      h1(
        class = "display-7",
        "Welcome to the KVFinder-web!",
        style = "margin-left: .5rem;"
      ),
      img(class = "col-sm-8", src = "www/cover.png", style="max-width: 1200px; margin-left: 1%; margin-right: 1%;"),
      h5(
        "A web application for cavity detection and characterization in any type of biomolecular structure.",
        style = "margin: 1rem;"
      ),
      hr(class = "my-1"),
      tags$button(
        class = "btn btn-default action-button",
        id = "more_button",
        type = "button",
        "More",
        style = "background-color: #6c757d; color:white; margin-top: 0.5rem;"
      )
    )
  return(jumb)
}
