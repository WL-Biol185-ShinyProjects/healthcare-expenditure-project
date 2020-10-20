library(shiny)
library(tidyverse)
library(nycflights13)

# Define server logic required to draw a histogram
function(input, output) {
  
  output$distPlot <- renderPlot({
    
    output$distancePlot <- renderPlot({
      flights %>%
        filter(carrier %in% input$airline) %>%
        ggplot(aes(distance, air_time)) +
          geom_point()
      
    })
    
    output$expenditureInfo <- renderDataTable({
      clickEvent <- input$expenditurePlotClick
      flights %>%
        filter(carrier %in% input$airline) %>%
        nearPoints(clickEvent)
      
    })
    
  })
  
}
    
    # # generate bins based on input$bins from ui.R
    # x    <- faithful[, 2] 
    # bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # 
    # # draw the histogram with the specified number of bins
    # hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
#   })
#   
# }