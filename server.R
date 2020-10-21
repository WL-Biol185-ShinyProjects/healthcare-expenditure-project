library(shiny)
library(tidyverse)
library(leaflet)
library(rgdal)

source("stateCSV1991Script.R")
statesGeo  <- rgdal::readOGR("states.geo.json")





# join leaflet with our state data

# Define server logic to draw plot
function(input, output) {
  
  
  # output$expenditurePlot <- renderPlot({
  #   expend <- input$expenditure
  #   df <- tables$expend
  #   state <- toString(input$state)
  #   state_df <- df %>%
  #     filter(State == state)
  #   ggplot(state_df, aes(Year, dollars)) +
  #     geom_line()
  #   # ggplot(df, aes(df$Year[df$State == input$state], df$dollars[df$State == input$state])) +
  #   #   geom_line()
  #   
  # })
  #   
  # output$expenditureInfo <- renderTable({
  #   clickEvent <- input$expenditurePlotClick
  #   tables$input
  #     # nearPoints(clickEvent)
  #     
  # })
  
  output$leafletPlot <- renderLeaflet({
    statesGeo@data <- left_join(statesGeo@data, tables[[input$expenditure]], 
                                by = c("NAME" = "State"))
    # yellow to red
    bins <- c(0, 10, 20, 50, 100, 200, 500, 1000, Inf)
    # palette is yellow or red - look at doc for other choices
    # domain - column on table to shade the states
    pal <- colorBin("YlOrRd", domain = tables[[input$expenditure]]$dollars, bins = bins)
    leaflet(statesGeo) %>%
      addTiles() %>%
      addPolygons(
        fillColor = ~pal(dollars),
        weight = 2,
        opacity = 1,
        color = "white",
        dashArray = "3",
        fillOpacity = 0.7)
    
  })
  
}



