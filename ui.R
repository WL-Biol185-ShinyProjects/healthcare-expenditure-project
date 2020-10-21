library(shiny)
library(leaflet)
 
# source("sidebar.R")
# source("main-panel.R")

# Define UI for application
fluidPage(
  
  titlePanel("Healthcare Expenditures by State"),
  
  sidebarPanel(
    selectInput(inputId = "expenditure",
                label = "Select expenditures:",
                choices = names(tables),
                multiple = TRUE
                # selected = ""
              ),
    selectInput(inputId = "state",
                label = "Select states:",
                choices = unique(tables$Population$State),
                multiple = TRUE)
  ),
  mainPanel(
    plotOutput(outputId = "expenditurePlot"
               # click = "expenditurePlotClick"
              ),
    leafletOutput(outputId = "leafletPlot"),
    tableOutput("expenditureInfo")
    
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

