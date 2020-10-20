library(shiny)
library(tidyverse)

# Define server logic to draw plot
function(input, output) {
  
  
  output$expenditurePlot <- renderPlot({
    expend <- input$expenditure
    df <- tables$expend
    ggplot(df, aes(df$Year[df$State == input$state], df$dollars[df$State == input$state])) +
      geom_line()
    
  })
    
  output$expenditureInfo <- renderTable({
    clickEvent <- input$expenditurePlotClick
    tables$input
      # nearPoints(clickEvent)
      
  })
  
}