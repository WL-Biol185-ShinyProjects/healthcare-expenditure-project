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
      menuItem("Introduction", tabName = "introductionTab", icon = icon("info")),
      menuItem("States", tabName = "statesTab", icon = icon("map-marker-alt")),
      menuItem("Gender", tabName = "genderTab", icon = icon("user-friends")),
      menuItem("Age", tabName = "ageTab", icon = icon("birthday-cake"))
    )
  ),
  dashboardBody(
    tabItems(
      
      tabItem(tabName = "introductionTab", fluidRow(
        h1(strong("Welcome to our healthcare expenditure project"), style = "color: #4DD217", align = "center"),
        br(),
        
        img(src = "US-flag-with-stethoscope-662-x-428-px-.jpg", height = 400, width = 400, align = "right")
        
      )),
      
      
      tabItem(tabName = "genderTab", fluidRow(
        h2("This is the gender tab")
        
      )),
      tabItem(tabName = "ageTab", fluidRow(
        h2("This is the age tab"),
        selectInput(inputId = "expenditure_gender",
                    label = "Select expenditure:",
                    choices = names(tables_age_2),
                    multiple = TRUE,
                    selected = "OutOfPocketSpendingPerCapita"
        ),
        selectInput(inputId = "gender",
                    label = "Select gender(s):",
                    choices = unique(tables_age_2$OutOfPocketSpendingPerCapita$group),
                    multiple = TRUE,
                    selected = "total"
        ),
        plotOutput(outputId = "genderPlot")
        
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

