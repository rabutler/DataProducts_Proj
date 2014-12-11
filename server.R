
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
  
  output$elevRisk <- renderPlot({
    
    X <- XX()
    G <- plotRisk(X, input$scen, input$var, input$res,input$month,input$thresh,
                  input$firstYear)
    G
  })
  output$summary <- renderPrint({'ok'})
  
  output$selectScenario <- renderUI({
    checkboxGroupInput("scen", "Scenarios:", listScenarios(), selected = listScenarios()[1])
  })
  
})
