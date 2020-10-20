library(ggplot2)
library(dplyr)
states<-as.data.frame(state.x77)
states$region <- tolower(rownames(states))
states_map <- map_data("state")
fact_join$`Life Exp` <- as.numeric(fact_join$`Life Exp`)
ggplot(fact_join, aes(long, lat, group = group))+
  geom_polygon(aes(fill = `Life Exp`), color = "white")+
  scale_fill_viridis_c(option = "C")+
  theme_classic()