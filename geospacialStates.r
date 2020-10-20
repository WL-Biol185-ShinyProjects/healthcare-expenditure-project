library(geojson)

states <- geojsonio::geojson_read("us-states.geojson", what = "sp")
class(states)

names(states)

m <- leaflet(states) %>%
  setView(-96, 37.8, 4) %>%
  addProviderTiles("MapBox", options = providerTileOptions(
    id = "mapbox.light",
    accessToken = Sys.getenv('MAPBOX_ACCESS_TOKEN')))

