# libraries are imported
library(shiny)
library(tidyverse)
library(leaflet)
library(rgdal)
library(formattable)
#library(viridis)


# files are sourced
source("stateCSV1991Script.R")
#source("stateCSV2001Script.r")
source("age_tidy.R")
source("gender_tidy.R")
source("NHE_projection_tidy.R")


# state coordinates data is imported from file
statesGeo  <- rgdal::readOGR("states.geo.json")


# Define server logic to draw plot and leaflet
function(input, output) {
  
  
  # expenditure plot is created
  output$expenditurePlot <- renderPlot({
    df <- tables[[input$expenditure]] %>%
      filter(State %in% input$state)
    ggplot(df, aes(Year, dollars, color = State)) +
      geom_line(aes(color = State)) +
      geom_point() +
      ylab("USD (millions)") +
      theme(axis.text = element_text(size = 12), axis.title = element_text(size = 14, face = "bold"),
            axis.title.x = element_text(vjust = -1), axis.title.y = element_text(vjust = 2),
            legend.text = element_text(size = 12)) +
      scale_x_continuous(breaks = seq(1991, 2015, 3))
  })
  
  output$state_info <- renderTable({
    df <- tables[[input$expenditure]] %>%
      filter(State %in% input$state)
    nearPoints(df, input$state_hover, threshold = 10, maxpoints = 1, addDist = TRUE)
  })
  
  
  # leaflet plot is created
  output$leafletPlot <- renderLeaflet({
    states_join <- tables[[input$expenditure]] %>%
      filter(Year == 2014)
    
    states_join$State <- as.factor(states_join$State)
    
    states_join$dollars <- as.integer(states_join$dollars)
    
    states_join$dollars <- comma(states_join$dollars)
    
    #states_join$dollars <- floor(states_join$dollars)
    
    statesGeo@data <- left_join(statesGeo@data, states_join, 
                                by = c("NAME" = "State"))
    
    
    
    
    # labels for the leaflet
    labels <- sprintf(
      "<strong>%s</strong><br/> $ %s million",
      #tables[[input$expenditure]]$State, tables[[input$expenditure]]$dollars
      # year_df <- tables[[input$expenditure]] %>%
      #   filter(Year == 2014) %>%
      #   select(dollars),
      statesGeo@data$NAME, statesGeo@data$dollars
      #label = h2(tables[[input$expenditure]]$State),
    ) %>% lapply(htmltools::HTML)
    
    
    # yellow to red
    # bins are created
    bins <- c(0, 100, 500, 1000, 2000, 4000, 8000, Inf)
    # palette is yellow or red - look at doc for other choices
    
    # palette is Reds
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
      
      # legend is added
      addLegend("bottomright",
                pal          = pal,
                values       = ~(dollars),
                opacity      = 0.8,
                #might need to adjust the amount in billions depending on the bins and on the file
                title        = "Millions of Dollars",
                labFormat    = labelFormat(suffix = "$"))
    
  })
  
  # gender plot is created
  output$genderPlot <- renderPlot({
    df_gender <- genders[[input$expenditure_gender]] %>%
      filter(group %in% input$gender)
    ggplot(df_gender, aes(year, USD, color = group)) +
      geom_line() +
      # geom_point() +
      xlab("Year") +
      ylab("USD (millions)") +
      theme(axis.text = element_text(size = 12), axis.title = element_text(size = 14, face = "bold"),
            axis.title.x = element_text(vjust = -1), axis.title.y = element_text(vjust = 2),
            legend.text = element_text(size = 12)) +
      scale_x_continuous(breaks = seq(2002, 2014, 2))
    
  })
  
  output$gender_info <- renderTable({
    df_gender <- genders[[input$expenditure_gender]] %>%
      filter(group %in% input$gender)
    nearPoints(df_gender, input$gender_hover, threshold = 10, maxpoints = 1, addDist = TRUE)
  })
  
  # age plot is created
  output$agePlot <- renderPlot({
    df_age <- ages[[input$expenditure_age]] %>%
      filter(ageGroup %in% input$age)
    ggplot(df_age, aes(year, USD, color = ageGroup)) +
      geom_line() +
      xlab("Year") +
      ylab("USD (millions)") +
      theme(axis.text = element_text(size = 12), axis.title = element_text(size = 14, face = "bold"),
            axis.title.x = element_text(vjust = -1), axis.title.y = element_text(vjust = 2),
            legend.text = element_text(size = 12)) +
      scale_x_continuous(breaks = seq(2002, 2014, 2))
    
  })
  
  # projections plot is created
  output$projectionsPlot <- renderPlot({
    df_projection <- NHE_tidy %>%
      filter(Expenditure %in% input$projection)
    ggplot(df_projection, aes(year, USD)) +
      geom_line(aes(color = Expenditure)) +
      xlab("Year") +
      ylab("USD (billions)") +
      theme(axis.text = element_text(size = 12), axis.title = element_text(size = 14, face = "bold"),
            axis.title.x = element_text(vjust = -1), axis.title.y = element_text(vjust = 2),
            legend.text = element_text(size = 12)) +
      scale_x_continuous(breaks = seq(2012, 2028, 2))
    
  })
  
}