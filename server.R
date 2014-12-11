
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
  
  output$prctPlotTitle <- renderText({
    if(length(input$res1)==2){
      resTitle <- 'Bronco Reservoir and Deep Snow Lake'
    } else{
      resTitle <- switch(input$res1,'Bronco' = 'Bronco Reservoir','Deep Snow' = 'Deep Snow Lake')
    }
    paste(resTitle,
          switch(input$month1,'Jan'='January', 'Feb'='February',
                 'Mar'='March','Apr'='April', 'May' = 'May', 'Jun'='June',
                 'Jul'='July', 'Aug'='August','Sep'='September', 
                 'Oct'='October','Nov'='November', 'Dec'='December',
                 'MaxAnn'='Annual Maximum','MinAnn'='Annual Minimum'),
          input$var1)
  })
  
  output$prctPlot <- renderPlot({
    plotPercentiles(XX(),input$scen1, input$var1, input$res1,input$month1,input$quant,
                    input$firstYear1)
  })
  
  output$summary <- renderPrint({'ok'})
  
  output$selectScenario <- renderUI({
    checkboxGroupInput("scen", "Scenarios:", listScenarios(), selected = listScenarios()[1])
  })
  
  output$selectScenario1 <- renderUI({
    checkboxGroupInput("scen1", "Scenarios:", listScenarios(), selected = listScenarios()[1])
  })
  
})
