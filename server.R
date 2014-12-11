
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(ggplot2)
library(plyr)
#source(plotSubset.R)

shinyServer(function(input, output) {
  
  listScenarios <- reactive({
    levels(XX()$Scenario)
  })
  
  XX <- reactive({readMyTable()})
  
  riskResults <- reactive({
    plotRisk(XX(), input$scen, input$var, input$res,input$month,input$thresh,
             input$firstYear)
  })
  
  output$elevRisk <- renderPlot({
    
    riskResults()$plot
  })
  
  output$plotTitle <- renderText({
    labUnit <- ifelse(input$var == 'Pool Elevation','\'',' acre-ft')
    paste('Percent of Traces <= ',prettyNum(input$thresh, big.mark = ','),labUnit,
          ' in Each Year',sep = '')
  })
  
  output$tableTitle <- renderText({
    labUnit <- ifelse(input$var == 'Pool Elevation','\'',' acre-ft')
    paste('Percent of Traces <= ',prettyNum(input$thresh, big.mark = ','),
          labUnit,' 1 or More Times between ', input$firstYear[1], 
          ' and ',input$firstYear[2], sep = '')
  })
  
  output$prctTracesTable <- renderTable({
    riskResults()$table
  },include.rownames = FALSE)
  
  output$summary <- renderPrint({'ok'})
  
  output$selectScenario <- renderUI({
    checkboxGroupInput("scen", "Scenarios:", listScenarios(), selected = listScenarios()[1])
  })
  
})
