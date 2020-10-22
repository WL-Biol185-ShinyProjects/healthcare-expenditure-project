library(shiny)
library(leaflet)
library(shinydashboard)
 
# source("sidebar.R")
# source("main-panel.R")

# Define UI for application
dashboardPage(skin = "green",
  dashboardHeader(title = "Heathcare Expenditures in the United States", titleWidth = 600),
  dashboardSidebar(width = 240,
    sidebarMenu(
      menuItem("States", tabName = "statesTab", icon = icon("map-marker-alt")),
      menuItem("Gender", tabName = "genderTab", icon = icon("user-friends")),
      menuItem("Age", tabName = "ageTab", icon = icon("birthday-cake"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "genderTab", fluidRow(
        h2("This is the gender tab")
        
      )),
      tabItem(tabName = "ageTab", fluidRow(
        h2("This is the age tab")
        
      )),
      tabItem(tabName = "statesTab", fluidRow(
        h2("This is the states tab"),
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
                    selected = "Virginia"),
        plotOutput(outputId = "expenditurePlot"
                   # click = "expenditurePlotClick"
                  ),
        leafletOutput(outputId = "leafletPlot")
      ))
    )
    
  )
)

