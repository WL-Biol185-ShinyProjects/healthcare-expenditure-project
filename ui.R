library(shiny)
library(leaflet)
 
# source("sidebar.R")
# source("main-panel.R")

# Define UI for application
fluidPage(
  
  dashboardPage(skin = "black",
                dashboardHeader(title = "Healthcare Expenditures in the United States"),
                dashboardSidebar(
                  sidebarMenu(
                    # menuItem("Gender", tabName = "genderTab"),
                    # menuItem("Age", tabName = "ageTab"),
                    menuItem("States", tabName = "statesTab")
                  )
                ),
                
  dashboardBody(
    tabItems(
      # tabItem(tabName = "genderTab", genderTab),
      # tabItem(tabName = "ageTab", ageTab),
      tabItem(tabName = "statesTab", statesTab)
    )
  )
  
  
  titlePanel("Healthcare Expenditures by State"),
  
  sidebarPanel(
    selectInput(inputId = "expenditure",
                label = "Select expenditures:",
                choices = names(tables),
                multiple = TRUE,
                selected = "Population"
              ),
    selectInput(inputId = "state",
                label = "Select states:",
                choices = unique(tables$Population$State),
                multiple = TRUE,
                selected = "Virginia")
  ),
  mainPanel(
    plotOutput(outputId = "expenditurePlot"
               # click = "expenditurePlotClick"
              ),
    leafletOutput(outputId = "leafletPlot"),
    tableOutput("expenditureInfo")
    
  )
)
)

