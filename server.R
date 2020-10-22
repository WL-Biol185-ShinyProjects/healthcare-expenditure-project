library(shiny)
library(tidyverse)
library(leaflet)
library(rgdal)
#library(viridis)

source("stateCSV1991Script.R")
statesGeo  <- rgdal::readOGR("states.geo.json")


# Define server logic to draw plot and leaflet
function(input, output) {
  
  
  output$expenditurePlot <- renderPlot({
    df <- tables[[input$expenditure]] %>%
      filter(State %in% input$state)
    ggplot(df, aes(Year, dollars)) +
      geom_line(aes(color = State))
  })

  output$expenditureInfo <- renderTable({
    clickEvent <- input$expenditurePlotClick
    # nearPoints(clickEvent)
  })
  
  output$leafletPlot <- renderLeaflet({
    statesGeo@data <- left_join(statesGeo@data, tables[[input$expenditure]], 
                                by = c("NAME" = "State"))
    # yellow to red
    bins <- c(0, 100, 500, 1000, 2000, 4000, 8000, Inf)
    # palette is yellow or red - look at doc for other choices
    # domain - column on table to shade the states
    pal <- colorBin("Reds", domain = tables[[input$expenditure]]$dollars, bins = bins)
    leaflet(statesGeo) %>%
      setView(-96, 37.8, 4) %>%
      addTiles() %>%
      addPolygons(
        fillColor = ~pal(dollars),
        weight = 2,
        #work on the label functionality
        label = h2(c(tables[[input$State]])),
        opacity = 1,
        color = "white",
        dashArray = "3",
        fillOpacity = 0.7
        
        ) %>%
      
      addLegend("bottomright",
        pal          = pal, 
        values       = ~(dollars), 
        opacity      = 0.8,
        #might need to adjust the amount in billions depending on the bins and on the file
        title        = "Amount in Billions",
        labFormat    = labelFormat(suffix = "$"))
    
  })
  
}



