library(shiny)
library(leaflet)


function(input, output) {
  
  # creating vectors of possible latitude and longitude values
  lats <- -90:90
  lons <- -180:180
  
  output$worldMap <- renderLeaflet({
    
    # everytime button is pressed, map is updated
    # dummy var
    # btn <- input$newButton
    
    # leaflet() %>%
    #   # sample() randdomly samples values from a vector
    #   setView(lng = sample(lons, 1), lat = sample(lats, 1), zoom = 5) %>%
    #   addTiles()
  
    # runs when input inside changes
    # helps with gray boxes showing up when map refreshes
    observe({
      btn <- input$newButton
      
      leafletProxy("worldMap") %>%
        setView(lng = sample(lons, 1), lat = sample(lats, 1), zoom = 5)
        
      
    })
    
    
  })
  
}