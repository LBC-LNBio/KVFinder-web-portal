#' Take a snapshot
#'
#' @param input shiny input
#' @param output shiny output
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page).
#'
#' @import shiny
#' @import NGLVieweR
#'
#' @export
#'

take_snapshot <- function(input, output, is_pg2) {
  if (is_pg2 == TRUE) {
    input_snapshot <- "input_snapshot_pg2"
    structure <- "structure_pg2"
  } else {
    input_snapshot <- "input_snapshot"
    structure <- "structure"
  }
  NGLVieweR_proxy(structure) %>%
    snapShot(
      param = list("antialias" = TRUE, trim = TRUE, transparent = TRUE, factor = 2)
    )
}
