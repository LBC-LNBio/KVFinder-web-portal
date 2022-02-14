#' Create jumbotron of main Run KVFinder page 
#' 
#' @import shiny
#' 

create_jumbotron <- function(){
  jumb <- tags$div(class = "jumbotron bg-primary", style = "max-height: 400px;height:56vh;",
           h1(class = "display-7", "Welcome to the KVFinder-web service!", style = "margin-top:-5%;margin-bottom:0%"),
           img(class ="col-sm-8" ,src="https://lnbio.cnpem.br/wp-content/uploads/2022/01/space-segmentation.png"),
           p(class = 'lead', "A web service for cavity detection and characterization in any type of biomolecular structure"),
           hr(class = "my-1"),
           tags$button(class = "btn btn-default action-button", id = "more_button", type = "button", "More", style = "background-color: #6c757d; color:white")  
  )
  return(jumb)
}