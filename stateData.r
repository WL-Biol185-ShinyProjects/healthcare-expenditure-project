#imports
library(dbplyr)

# this file takes in state data

# .csv file with our data is imported
stateData <- read.csv("Table 21.csv", header = TRUE)

# we delete rows that are not state names (United States, Regions)
# rows to be deleted: 1, 2, 9, 16, 30, 43, 48, 54, 61, 62, 63
stateData <- stateData[-c(1, 2, 9, 16, 30, 43, 48, 54, 61, 62, 63), ]
