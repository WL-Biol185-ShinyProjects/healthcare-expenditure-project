library(shiny)

sidebar <- sidebarPanel(
  sliderInput("bins",
              "Number of bins:",
              min = 1,
              max = 300,
              value = 30)
)