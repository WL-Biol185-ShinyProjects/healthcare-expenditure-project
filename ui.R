library(shiny)
# library(leaflet)
 
# source("sidebar.R")
# source("main-panel.R")

# Define UI for application
fluidPage(
  
  sidebarPanel(
    selectInput(inputId = "expenditure",
                label = "Select expenditures:",
                choices = names(tables),
                multiple = TRUE,
                # selected = ""
              ),
    selectInput(inputId = "state",
                label = "Select states",
                unique(tables$Population$State),
                multiple = TRUE)
  ),
  mainPanel(
    plotOutput("expenditurePlot",
               click = "expenditurePlotClick"
              ),
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

