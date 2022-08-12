#' Function that creates the jumbotron of the main Run KVFinder page
#'
#' @import shiny
#'

create_jumbotron <- function() {
  jumb <-
    tags$div(
      class = "jumbotron bg-primary",
      style = "padding: 1rem 2rem;",
      h1(
        class = "display-7",
        "Welcome to the KVFinder-web service!",
        style = "margin-left: .5rem;"
      ),
      img(class = "col-sm-8" , src = "www/cover_all3.png"),
      h5(
        "A web service for cavity detection and characterization in any type of biomolecular structure",
        style = "margin: 1rem;"
      ),
      hr(class = "my-1"),
      tags$button(
        class = "btn btn-default action-button",
        id = "more_button",
        type = "button",
        "More",
        style = "background-color: #6c757d; color:white"
      )
    )
  return(jumb)
}