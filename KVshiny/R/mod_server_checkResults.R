#' Check results
#' 
#' @param input shiny input
#' @param output shiny output
#' @param run_id current run id
#' @param is_pg2 logical TRUE/FALSE. If TRUE, we calling to create result in page 2 (get latest results page). 
#' 
#' @import shiny
#' @import RcppTOML
#' @import data.table
#' @import DT
#' @import blogdown
#' @export
#' 

check_results <- function(input, output, run_id, is_pg2){

    #check which page to use and guide the output
    if(is_pg2 == TRUE){
      output_status <- "output_status_pg2"
      download <- "download_pg2"
      download2 <- "download2_pg2"
      download_results <- "download_results_pg2"
      download_results2 <- "download_results2_pg2"
      results_table <- "results_table_pg2"
      table_out <- "table_out_pg2"
      view_output <- "view_output_pg2"
      view_str <- "view_str_pg2"
    } else{
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
    
    #access results 
    #get_output <- GET(url = paste("http://10.0.0.123:8081/", run_id, sep = ""))
    get_output <- GET(url = paste("http://localhost:8081/", run_id, sep = "")) #use localhost
    
    #check if get returned a OK success status
    if(get_output$status_code == 200){
      #get content
      content_get_output <- content(get_output)
      #get status
      var_status <<- content_get_output$status

      #var_status <- "running"
      #get structure to use outside this scope
      result_pdb_cav <- content_get_output$output$pdb_kv
      
      #Parse results if status is completed
      if(var_status == "completed"){
        output[[output_status]] <- renderValueBox({
          valueBox(
            value = paste("Status: ", var_status,sep = ""),
            subtitle = paste("Job ID:",  run_id, sep = ""),
            icon = icon("check-circle"), 
            color = "success"
          )
        })
        
        
        #retrieve input pdb to be used in visualization
        #retrieve_get <- GET(url = paste("http://10.0.0.123:8081/retrieve-input/", run_id, sep = ""))
        retrieve_get <- GET(url = paste("http://localhost:8081/retrieve-input/", run_id, sep = "")) #use local host
        
        retrieve_content <- content(retrieve_get)
        retrieve_input_pdb <- retrieve_content$input$pdb
        
        
        #table with results
        result_toml <- parseTOML(input = content_get_output$output$report,fromFile = FALSE,escape = TRUE)$RESULTS
        #print(names(result_toml))
        
        if(length(result_toml$AREA) == 0){
          shinyalert("Oops!", "No cavity found. Please check the input parameters and try again.", type = "warning")
        } else{
        
        #create result table
        output[[results_table]] <- renderUI({
          DT::dataTableOutput(table_out)
        })
        output[[table_out]] <- DT::renderDataTable(data.table(
          `Cavity ID` = names(result_toml$AREA),
          `Area (A^2)` = unlist(result_toml$AREA),
          `Volume (A^3)` = unlist(result_toml$VOLUME)
        ), filter = c("none"), 
        style = "auto",
        options = list(dom = 'lBfrtip', buttons = c('excel', 'pdf')),
        extensions = 'Buttons')
        #save cavities name
        cav_out_names <- names(result_toml$AREA)

        #Download 3D input structure with cavities
        pdb_all <- paste(retrieve_input_pdb, result_pdb_cav,sep = "\n")
        #create download button
        output[[download]] <- renderUI({
          downloadButton(download_results, 'Download cavities', style="color: #fff; background-color: #6c757d; border-color: #6c757d")
        })
        output[[download_results]] <- downloadHandler(
          filename = function() {
            paste("KVfinder_results_",retrieve_content$id,".pdb",sep = "")
          },
          content = function(filename) {
            write(pdb_all,filename)
          }
        )
        
        
        
        
        #download input parameter information 
        param_list <- list(Result_ID = retrieve_content$id, Create_time = retrieve_content$created_at,  Result_param = retrieve_content$input$settings, Result_output = result_toml)
        output[[download2]] <- renderUI({
          downloadButton(download_results2, 'Download Results', style="color: #fff; background-color: #6c757d; border-color: #6c757d")
        })
        output[[download_results2]] <- downloadHandler(
          filename = function() {
            #paste("kvfinder_output",".pdb",sep = "")
            paste("KVfinder_results_",retrieve_content$id,".toml",sep = "")
          },
          content = function(filename) {
            #write(content_get_output$output$pdb_kv,filename)
            write_toml(param_list, output = filename)
            #write.config(config.dat = result_toml, file.path = filename, 
            #             write.type = "toml")
          }
        )
        
        #create visualization
        output[[view_output]] <- renderUI({
          actionButton(inputId = view_str,label = "View", icon = icon("eye"), style="color: #fff; background-color: #6c757d; border-color: #6c757d")
        })
        
        
        
        #print(retrieve_content)
        
        #create list to store results 
        result_list <- list(
          retrieve_input_pdb = retrieve_input_pdb,
          result_pdb_cav = result_pdb_cav,
          result_cav_names = cav_out_names,
          result_toml = result_toml
        )
        return(result_list)
        }
        
      } else {
        output[[output_status]] <- renderValueBox({
          valueBox(
            value = paste("Status: ", content_get_output$status,sep = ""),
            subtitle = paste("Job ID:",  run_id, sep = ""),
            #subtitle = HTML(paste(p(paste("Job ID:",  run_id, sep = "")),p("teste"))),
            icon = icon("exclamation"), 
            color = "warning",
            footer = div("The status is automatically updated each 5 seconds. Please, don't refresh the page.")
          )
        })
        
      }
      
    } else{
      output[[output_status]] <- renderValueBox({
        valueBox(
          value = paste("An error occurred.", "Please check your run ID.", "If the problem persist, please contact us."),
          subtitle = paste("Job ID:",  run_id, sep = ""),
          icon = icon("exclamation-triangle"), 
          color = "danger"
        )
      })
    }
    return(var_status)
}