library(shiny)
library(leaflet)
library(shinydashboard)
 
source("ui.R")
source("stateCSV1991Script.R")
source("stateCSV2001Script.r")
source("age_tidy.R")
source("gender_tidy.R")

# Define UI for application
dashboardPage(skin = "green",
  dashboardHeader(title = "Heathcare Expenditures in the United States", titleWidth = 600),
  dashboardSidebar(width = 240,
    sidebarMenu(
      menuItem("Introduction", tabName = "introductionTab", icon = icon("info")),
      menuItem("States", tabName = "statesTab", icon = icon("map-marker-alt")),
      menuItem("Gender", tabName = "genderTab", icon = icon("user-friends")),
      menuItem("Age", tabName = "ageTab", icon = icon("birthday-cake")),
      menuItem("Projections", tabName = "projectionsTab", icon = icon("chart-line"))
    )
  ),
  
  dashboardBody(
    tabItems(
      
      tabItem(tabName = "introductionTab", fluidRow(
         h1(strong("Welcome to our healthcare expenditure project"), style = "color: #4DD217", align = "center"),
         br(),
         
         img(src = "US-flag-with-stethoscope-662-x-428-px-.jpg", height = 400, width = 400, align = "right"),
         br(),
         
       )),
       
       
       tabItem(tabName = "genderTab", fluidRow(
         h1(strong("This is the gender tab"), style = "color: #4DD217", align = "center"),
         br(),
         
         selectInput(inputId = "expenditure_gender",
                     label = "Select expenditure:",
                     choices = names(genders),
                     multiple = FALSE,
                     selected = "OutOfPocketSpendingPerCapita"
         ),
         selectInput(inputId = "gender",
                     label = "Select gender(s):",
                     choices = unique(genders$OutOfPocketSpendingPerCapita$group),
                     multiple = TRUE,
                     selected = "total"
         ),
         plotOutput(outputId = "genderPlot")
         
         
       )),
      
       tabItem(tabName = "ageTab", fluidRow(
         h1(strong("This is the age tab"), style = "color: #4DD217", align = "center"),
         br(),
         
         selectInput(inputId = "expenditure_age",
                     label = "Select expenditure:",
                     choices = names(ages),
                     multiple = FALSE,
                     selected = "OutOfPocketSpendingPerCapita"
                     ),
         selectInput(inputId = "age",
                     label = "Select age group(s):",
                     choices = unique(ages$TotalPersonalHealthCare$ageGroup),
                     multiple = TRUE,
                     selected = "0-18"
                     ),
         plotOutput(outputId = "agePlot")
        
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
                     label = "Select state(s)/region(s):",
                     choices = unique(tables$Population$State),
                     multiple = TRUE,
                     selected = "Virginia"
                     ),
         plotOutput(outputId = "expenditurePlot"
                    # click = "expenditurePlotClick"
                   ),
         leafletOutput(outputId = "leafletPlot")
       )),
      
         
       tabItem(tabName = "projectionsTab", fluidRow(
         h1(strong("Welcome to our projections tab"), style = "color: #4DD217", align = "center"),
         br(),
       
         ))
    )
  )
)  



