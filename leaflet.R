library(leaflet)

# shows map
leaflet() %>% addTiles()

# setView - starts map at specified lat and long
# play with zoom to get best fit
# ask whitworth for US lat and long centers
leaflet() %>% addTiles() %>% 
  setView(lng = -79.442778, lat = 37.783889, zoom = 12)

leaflet() %>% 
  setView(lng = -79.442778, lat = 37.783889, zoom = 8) %>% 
  addProviderTiles(provider = providers$NASAGIBS.ViirsEarthAtNight2012)

# removes features for a simpler map
leaflet() %>% 
  setView(lng = -79.442778, lat = 37.783889, zoom = 12) %>% 
  addProviderTiles(providers$CartoDB.Positron)

# layer in live data, doesn't update by itself
# would need to code app to update at a particular frequency
leaflet() %>% 
  addTiles() %>% 
  setView(lng = -79.442778, lat = 37.783889, zoom = 8) %>%
  addWMSTiles(
    "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",
    layers = "nexrad-n0r-900913",
    options = WMSTileOptions(format = "image/png", transparent = TRUE),
    attribution = "Weather data © 2012 IEM Nexrad"
  )


# lat/latitude and lon/longitude as column names - leaflet will identify these
lex <- data.frame( lat    = c(37.789444 , 37.787673  ,  37.785624  )
                   , lon    = c(-79.441725, -79.443623 , -79.441544  )
                   , place  = c("Lab"     , "Classroom", "Thai food!")
                   , rating = c(7         , 5          , 10          )
                   , stringsAsFactors = FALSE
)


leaflet(data = lex) %>% 
  setView(lng = -79.442778, lat = 37.783889, zoom = 12) %>%
  addTiles() %>% 
# this creates pop up markers for locations in lex table
  # addMarkers(popup = ~place)
# changing popup to label shows a label when you highlight the pop up
# clusterOptions consolidates popups in same area
  addMarkers(label = ~place,
             clusterOptions = markerClusterOptions())

leaflet(data = lex) %>% 
  setView(lng = -79.442778, lat = 37.783889, zoom = 12) %>%
  addTiles() %>% 
# circles are sized based on rating (radius)
# size of circles relative to map but not relative to screen
  addCircleMarkers(radius = ~rating,
                   label = ~place)

leaflet(data = lex) %>% 
  setView(lng = -79.442778, lat = 37.783889, zoom = 12) %>%
  addTiles() %>% 
  # opposite behavior as addCircleMarkers()
  addCircles(radius = ~rating,
                   label = ~place)
