library(shiny)
library(leaflet)
library(shinydashboard)
 
# source("sidebar.R")
# source("main-panel.R")

# Define UI for application
dashboardPage(
  dashboardHeader(title = "HeathcareExpenditures"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("States", tabName = "statesTab", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "genderTab", fluidRow(
        
      ))
    )
    
  )
)
  
  # dashboardPage(skin = "green",
  #               dashboardHeader(title = "Healthcare Expenditures in the United States", titleWidth = 600),
  #               dashboardSidebar(width = 120,
  #                 sidebarMenu(
  #                   # menuItem("Gender", tabName = "genderTab"),
  #                   # menuItem("Age", tabName = "ageTab"),
  #                   menuItem("States", tabName = "statesTab")
  #                 )
  #               ),
  #               
  # dashboardBody(
  #   
  #   
  #   
  #   tabItems(
  #     # 
  #     # tabItem(tabName = "ag
  
  
  #titlePanel("Healthcare Expenditures by State"),
  
#   sidebarPanel(
#     selectInput(inputId = "expenditure",
#                 label = "Select expenditures:",
#                 choices = names(tables),
#                 multiple = TRUE,
#                 selected = "Population"
#               ),
#     selectInput(inputId = "state",
#                 label = "Select states:",
#                 choices = unique(tables$Population$State),
#                 multiple = TRUE,
#                 selected = "Virginia")
#   ),
#   mainPanel(
#     plotOutput(outputId = "expenditurePlot"
#                # click = "expenditurePlotClick"
#               ),
#     leafletOutput(outputId = "leafletPlot"),
#     tableOutput("expenditureInfo")
#     
#   )
# )
# )

