library(shiny)
library(tidyverse)
library(leaflet)
library(rgdal)
#library(viridis)


source("stateCSV1991Script.R")
#source("stateCSV2001Script.r")
source("age_tidy.R")
source("gender_tidy.R")
source("NHE_projection_tidy.R")


statesGeo  <- rgdal::readOGR("states.geo.json")


# Define server logic to draw plot and leaflet
function(input, output) {
  
  
  output$expenditurePlot <- renderPlot({
    df <- tables[[input$expenditure]] %>%
      filter(State %in% input$state)
    ggplot(df, aes(Year, dollars)) +
      geom_line(aes(color = State))
  })

  # output$expenditureInfo <- renderTable({
  #   clickEvent <- input$expenditurePlotClick
  #   # nearPoints(clickEvent)
  # })
  
  labels <- sprintf(
    "<strong>%s</strong><br/>%g people / mi<sup>2</sup>",
    #tables[[input$expenditure]]$State, tables[[input$expenditure]]$dollars
    unique(tables$Medicare$State), tables$Medicare$dollars
    #label = h2(tables[[input$expenditure]]$State),
    ## try unique to pull state names
  ) %>% lapply(htmltools::HTML)
  
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
        highlight = highlightOptions(
          weight = 5,
          color = "#666",
          dashArray = "",
          fillOpacity = 0.7,
          bringToFront = TRUE),
        label = labels,
        opacity = 1,
        color = "white",
        dashArray = "3",
        fillOpacity = 0.7,
        labelOptions = labelOptions(
          style = list("font-weight" = "normal", padding = "3px 8px"),
          textsize = "15px",
          direction = "auto")
      
        ) %>%

      addLegend("bottomright",
        pal          = pal,
        values       = ~(dollars),
        opacity      = 0.8,
        #might need to adjust the amount in billions depending on the bins and on the file
        title        = "Millions of Dollars",
        labFormat    = labelFormat(suffix = "$"))
    
  })
  
  output$genderPlot <- renderPlot({
    df_gender <- genders[[input$expenditure_gender]] %>%
      filter(group %in% input$gender)
    ggplot(df_gender, aes(year, USD, color = group)) +
      geom_line()

  })
  
  output$agePlot <- renderPlot({
    df_age <- ages[[input$expenditure_age]] %>%
      filter(ageGroup %in% input$age)
    ggplot(df_age, aes(year, USD, color = ageGroup)) +
      geom_line()
    
  })
  
  output$projectionsPlot <- renderPlot({
    df_projection <- NHE_tidy %>%
      filter(Expenditure %in% input$projection)
    ggplot(df_projection, aes(year, USD)) +
      geom_line(aes(color = Expenditure))
    
  })
  
}



