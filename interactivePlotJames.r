library(tidyverse)
library(shiny)
library(nycflights13)

function(input, output) {
  
  output$distancePlot <- renderPlot({
    flights %>%
      filter(carrier == input$airline) %>%
      ggplot(aes(distance, air_time)) + 
      geom_point()
  })
  
  output$flightInfo <- renderText({
    clickEvents <- input$distancePlotClick
    flights %>%
      filter(carrier)
  })
}
