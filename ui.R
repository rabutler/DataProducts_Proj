
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
source('plotSubset.R')

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Sample Elevation Plot"),
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(
    checkboxGroupInput('scen','Scenarios:',choices = c('Baseline' = 'Baseline',
                       'Scenario A'='Scenario A'), selected = 'Baseline'),
    radioButtons("res",
                "Select the reservoir:",
                choices = c('Bronco Reservoir' = 'Bronco', 
                'Deep Snow Lake'= 'Deep Snow'),
                selected = 'Bronco'),
    radioButtons('var','Variable:',choices = c('Pool Elevation' = 'Pool Elevation',
                'Storage' = 'Storage'), selected = 'Pool Elevation'),
    selectInput('month','Select the Month:',
                 choices = c('January' = 'Jan', 'February' = 'Feb',
                 'March' = 'Mar','April' = 'Apr', 'May' = 'May', 'June' = 'Jun',
                 'July' = 'Jul', 'August'='Aug','September' = 'Sep', 
                 'October' = 'Oct','November' = 'Nov','December' = 'Dec'),
                 selected = 'Dec'),
    numericInput('thresh','Threshold:',1100),
    sliderInput('firstYear','First Year:',2015,2019,value = 2015, step = 1,
                format = '####'),
    sliderInput('lastYear','Last Year:',2015,2019,value = 2019,step = 1,
                format = '####')
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("elevRisk")
  )
))
