#' Function that check and ouput results in the KVFinder interface
#'
#' @param input shiny input
#' @param output shiny output
#' @param run_id current run id
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page).
#' @param url_address url address to conexion
#' @param session
#'
#' @import shiny
#' @import RcppTOML
#' @import data.table
#' @import DT
#' @import blogdown
#' @import shinyWidgets
#' @export
#'

check_results <- function(input, output, run_id, is_pg2, url_address, session) {
  # check which page to output the results (main page or get latest results page - pg2)
  # this block was created to allow the use of this function in the main or secondary page
  if (is_pg2 == TRUE) { # get latest results page
    output_status <- "output_status_pg2"
    download <- "download_pg2"
    download2 <- "download2_pg2"
    download_results <- "download_results_pg2"
    download_results2 <- "download_results2_pg2"
    results_table <- "results_table_pg2"
    table_out <- "table_out_pg2"
    view_output <- "view_output_pg2"
    view_str <- "view_str_pg2"
  } else { # main page
    output_status <- "output_status1"
    download <- "download"
    download2 <- "download2"
    download_results <- "download_results"
    download_results2 <- "download_results2"
    results_table <- "results_table"
    table_out <- "table_out"
    view_output <- "view_output"
    view_str <- "view_str"
  }

  # obtain results from the server
  # get_output <- GET(url = paste("http://10.0.0.123:8081/", run_id, sep = ""))
  get_output <- GET(url = paste(url_address, run_id, sep = "")) # use localhost

  # check if the status is 200 and process the output
  if (get_output$status_code == 200) {
    # get content
    content_get_output <- content(get_output)
    # get status
    var_status <<- content_get_output$status
    # get cavity 3D structure to use outside this scope
    result_pdb_cav <- content_get_output$output$pdb_kv
    # Process results if status is completed
    if (var_status == "completed") {
      # render status message
      output[[output_status]] <- renderValueBox({
        valueBox(
          value = paste("Status: ", var_status, sep = ""),
          subtitle = paste("Job ID:", run_id, sep = ""),
          icon = icon("check-circle"),
          color = "success"
        )
      })

      # retrieve the input PDB to be used in the ouput visualization
      # retrieve_get <- GET(url = paste("http://10.0.0.123:8081/retrieve-input/", run_id, sep = ""))
      retrieve_get <- GET(url = paste(url_address, "retrieve-input/", run_id, sep = "")) # use local host
      # get content
      retrieve_content <- content(retrieve_get)
      # get retrivied input PDB
      retrieve_input_pdb <- retrieve_content$input$pdb
      # table with results
      result_toml <- parseTOML(input = content_get_output$output$report, fromFile = FALSE, escape = TRUE)$RESULTS
      #print(names(result_toml))
      #print(result_toml$MAX_DEPTH)
      # check if the at least one cavity was found
      if (length(result_toml$AREA) == 0) {
        shinyWidgets::sendSweetAlert(session = session, title = "Oops!", text = "No cavity found. Please check the input parameters and try again.", type = "warning")
      } else { # if cavities were found
        # create result table
        output[[results_table]] <- renderUI({
          DT::dataTableOutput(table_out)
        })
        #print(result_toml$AVG_HYDROPATHY)
        output[[table_out]] <- DT::renderDataTable(
          data.table(
            `ID` = names(result_toml$AREA),
            `Area (A²)` = unlist(result_toml$AREA),
            `Vol. (A³)` = unlist(result_toml$VOLUME),
            `Avg Dep. (A)` = unlist(result_toml$AVG_DEPTH),
            `Max Dep. (A)` = unlist(result_toml$MAX_DEPTH),
            `Avg Hyd.` = unlist(result_toml$AVG_HYDROPATHY[names(result_toml$AVG_HYDROPATHY) != 'EisenbergWeiss'])
          ),
          filter = c("none"),
          style = "auto",
          options = list(dom = "lBfrtip", 
                         buttons = c("excel", "pdf"), 
                         autoWidth = TRUE,
                         scrollX = TRUE,
                         columnDefs = list(list(targets=c(1), visible=TRUE, width='10%'))
                         ),
          extensions = "Buttons"
        )
        # save cavities name
        cav_out_names <- names(result_toml$AREA)
        # Download the 3D retrivied input structure with cavities
        pdb_all <- paste(retrieve_input_pdb, result_pdb_cav, sep = "\n")
        # create download button
        output[[download]] <- renderUI({
          downloadButton(download_results, "Download cavities", style = "color: #fff; background-color: #6c757d; border-color: #6c757d")
        })
        output[[download_results]] <- downloadHandler(
          filename = function() {
            paste("KVfinder_results_", retrieve_content$id, ".pdb", sep = "")
          },
          content = function(filename) {
            write(pdb_all, filename)
          }
        )
        # Create button to download input parameter and job information
        param_list <- list(Result_ID = retrieve_content$id, Create_time = retrieve_content$created_at, Result_param = retrieve_content$input$settings, Result_output = result_toml)
        output[[download2]] <- renderUI({
          downloadButton(download_results2, "Download Results", style = "color: #fff; background-color: #6c757d; border-color: #6c757d")
        })
        output[[download_results2]] <- downloadHandler(
          filename = function() {
            paste("KVfinder_results_", retrieve_content$id, ".toml", sep = "")
          },
          content = function(filename) {
            write_toml(param_list, output = filename)
          }
        )
        # create visualization button
        output[[view_output]] <- renderUI({
          actionButton(inputId = view_str, label = "View", icon = icon("eye"), style = "color: #fff; background-color: #6c757d; border-color: #6c757d")
        })
        
        output$table_footer <- renderText({
          paste(
            p(strong("ID: "), "Cavity ID, ", strong("Area: "), "Cavity area, ", strong("Vol: "), "Cavity volume, ", strong("Avg Dep: "), "Cavity average depth ,", strong("Max Dep: "), "Cavity maximum depth, ", strong("Avg Hyd: "), "Cavity average hydropathy.")
          )
        })
        
        #get values of depth for each atom 
        str_cav = strsplit(result_pdb_cav, "\n")[[1]]
        get_atoms = str_cav[sapply(str_cav, function(x) startsWith(x, 'ATOM'))]
        #print(get_atoms[1:10])
        list_depth = as.numeric(sapply(get_atoms, function(x) strsplit(x, '\\s+')[[1]][10]))
        # create list to store results
        result_list <- list(
          retrieve_input_pdb = retrieve_input_pdb,
          result_pdb_cav = result_pdb_cav,
          result_cav_names = cav_out_names,
          result_toml = result_toml,
          list_depth = list_depth
        )
        return(result_list)
      }
    } else { # in case the job was not completed yet
      output[[output_status]] <- renderValueBox({
        valueBox(
          value = paste("Status: ", content_get_output$status, sep = ""),
          subtitle = paste("Job ID:", run_id, sep = ""),
          # subtitle = HTML(paste(p(paste("Job ID:",  run_id, sep = "")),p("teste"))),
          icon = icon("exclamation"),
          color = "warning",
          footer = div("The status is automatically updated each 5 seconds. Please, don't refresh the page.")
        )
      })
    }
  } else { # in case of job error
    output[[output_status]] <- renderValueBox({
      valueBox(
        value = paste("An error occurred.", "Please check your job ID.", "If the problem persist, please contact us."),
        subtitle = paste("Job ID:", run_id, sep = ""),
        icon = icon("exclamation-triangle"),
        color = "danger"
      )
    })
  }
  return(var_status)
}
