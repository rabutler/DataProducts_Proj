
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(markdown)
source('plotSubset.R')

shinyUI(navbarPage('Reservoir Conditions',
  
  tabPanel("Instructions",
    fluidRow(column(9,includeMarkdown('instructions.md')))
  ),
  
  tabPanel("Percentile Plot",
     titlePanel('Percentiles through time'),      
     # Sidebar to select all options
     sidebarLayout(
       sidebarPanel(
         # automatically update the scenarios selection based on the scenarios existing in the data
         htmlOutput('selectScenarioA'),
         checkboxGroupInput("resA",
                      "Select the reservoir:",
                      choices = c('Bronco Reservoir' = 'Bronco', 
                                  'Deep Snow Lake'= 'Deep Snow'),
                      selected = 'Bronco'),
         radioButtons('varA','Variable:',choices = c('Pool Elevation' = 'Pool Elevation',
                                                    'Storage' = 'Storage'), selected = 'Pool Elevation'),
         selectInput('monthA','Select the Month:',
                     choices = c('January' = 'Jan', 'February' = 'Feb',
                                 'March' = 'Mar','April' = 'Apr', 'May' = 'May', 'June' = 'Jun',
                                 'July' = 'Jul', 'August'='Aug','September' = 'Sep', 
                                 'October' = 'Oct','November' = 'Nov','December' = 'Dec',
                                 'Max Annual' = 'MaxAnn','Min Annual' = 'MinAnn'),
                     selected = 'Dec'),
         checkboxGroupInput('quant','Percentiles:',choice = c('Min' = 0, '10%' = .1, '20%' = .2, 
                            '30%' = .3, '40%' = .4, '50%' = .5, '60%' = .6, '70%' = .7,
                            '80%' = .8, '90%' = .9, 'Max' = 1), selected = c(.1,.5,.9)),
         sliderInput('firstYearA','Select Years:',2015,2024,value = c(2015,2024), step = 1,
                     format = '####')
       ),
       
       # Show a plot of the selected percentiles through time
       mainPanel(
         h4(textOutput('prctPlotTitle')),
         plotOutput("prctPlot")
       )
     )
  ),
  
  # Threshold Risks Panel
  tabPanel("Threshold Risks",
  
    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        #checkboxGroupInput('scen','Scenarios:',choices = c('Baseline' = 'Baseline',
         #                 'Scenario A'='Scenario A'), selected = 'Baseline'),
        htmlOutput('selectScenario'),
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
                     'October' = 'Oct','November' = 'Nov','December' = 'Dec',
                     'Max Annual' = 'MaxAnn','Min Annual' = 'MinAnn'),
                     selected = 'Dec'),
        numericInput('thresh','Threshold:',1100),
        sliderInput('firstYear','Select Years:',2015,2024,value = c(2015,2024), step = 1,
                    format = '####')
      ),
    
    # Show a plot of the generated distribution
      mainPanel(
        h4(textOutput('plotTitle')),
        plotOutput("elevRisk"),
        h5(textOutput('tableTitle')),
        tableOutput('prctTracesTable'),
        div(textOutput('validRanges'),style = 'color:red')
      )
    )
  )
))
