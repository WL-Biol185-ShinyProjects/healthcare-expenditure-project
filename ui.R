library(shiny)
library(leaflet)
library(shinydashboard)
 

source("stateCSV1991Script.R")
#source("stateCSV2001Script.r")
source("age_tidy.R")
source("gender_tidy.R")
source("NHE_projection_tidy.R")

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
         
         img(src = "US-flag-with-stethoscope-662-x-428-px-.jpg", height = 600, width = 600, align = "right"),
         h3(strong("Healthcare Expenditure data was compiled from the _____ was used to visualize the relationships between location, age, gender, and healthcare expenditure across the United States.")),
         h3(""),
         br()
         
       )),
      
      tabItem(tabName = "statesTab", fluidRow(
        h1(strong("States Tab"), style = "color: #4DD217", align = "center"),
        h3(strong("In this tab, you can examine relationships between different expenditures compared with different states/regions")),
        selectInput(inputId = "expenditure",
                    label = "Select expenditures:",
                    choices = names(tables),
                    multiple = FALSE,
                    selected = "Medicare"
        ),
        selectInput(inputId = "state",
                    label = "Select state(s)/region(s):",
                    choices = unique(tables$Medicare$State),
                    multiple = TRUE,
                    selected = "New York"
        ),
        plotOutput(outputId = "expenditurePlot"
                   # click = "expenditurePlotClick"
        ),
        h1(strong("2014 data"), style = "color: #4DD217", align = "center"),
        leafletOutput(outputId = "leafletPlot")
      )),
       
       
       tabItem(tabName = "genderTab", fluidRow(
         h1(strong("Gender Tab"), style = "color: #4DD217", align = "center"),
         h3(strong("In this tab, you can examine relationships between different expenditures compared with different genders")),
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
                     selected = "Total"
         ),
         plotOutput(outputId = "genderPlot")
         
         
       )),
      
       tabItem(tabName = "ageTab", fluidRow(
         h1(strong("Age Tab"), style = "color: #4DD217", align = "center"),
         h3(strong("In this tab, you can examine relationships between different expenditures compared with different age groups")),
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
         
       tabItem(tabName = "projectionsTab", fluidRow(
         h1(strong("Projections Tab"), style = "color: #4DD217", align = "center"),
         h3(strong("In this tab, you can examine projected expenditures up to the year 2028")),
         br(),
         selectInput(inputId = "projection",
                     label = "Select expenditure:",
                     choices = unique(NHE_tidy$Expenditure),
                     multiple = TRUE,
                     selected = "National Health Expenditures"
                    ),
         plotOutput(outputId = "projectionsPlot")
       
         ))
    )
  )
)  



