library(shiny)
# library(leaflet)
library(nycflights13)

# 
# source("sidebar.R")
# source("main-panel.R")

# Define UI for application that draws a histogram
fluidPage(
  
  sidebarPanel(
    selectInput(inputId = "airline",
                label = "Select airlines:",
                choices = unique(flights$carrier),
                multiple = TRUE,
                selected = "UA"
              )
  ),
  mainPanel(
    plotOutput("distancePlot",
               click = "distancePlotClick"
              ),
    tableOutput("flightInfo")
  )
)
  
  
  
  
  
  # # Application title
  # titlePanel("Old Faithful Geyser Data"),
  # 
  # # Sidebar with a slider input for number of bins 
  # sidebarLayout(sidebar, main_panel),
  #   
  #   # Show a plot of the generated distribution
  #   mainPanel(
  #     plotOutput("distPlot")
  #   )
  # )

