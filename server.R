
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
   
  output$elevRisk <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2] 
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
    X <- read.table('trimData.txt',header = T)
    G <- plotRisk(X, input$scen, input$var, input$res,input$month,input$thresh,
                  input$firstYear)
    G
  })
  output$summary <- renderPrint({'ok'})
  
})
