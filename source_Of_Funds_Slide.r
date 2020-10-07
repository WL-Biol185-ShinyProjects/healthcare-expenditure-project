#library imports
library(tidyverse)
library(tidyr)
library(dplyr)
library(readr)
library(ggplot2)

slide5_data <- read_csv("Table 06 Personal Health Care Expenditures.csv")
#takes the second row and makes it the column headers as characters
names(slide5_data) <- lapply(slide5_data[2, ], as.character)

#removes the following lines
slide5_data <- slide5_data[-1:-3,]

#removes the 3 empty columns
slide5_data <- slide5_data[,-10:-12]

#rename all of the column headers to be one word
slide5_data <- rename(slide5_data, outOfPocket = "Out of Pocket")
slide5_data <- rename(slide5_data, healthInsurance = "Health Insurance2")
slide5_data <- rename(slide5_data, privateHealthInsurance = "Private Health Insurance")



#removes all of the "$"
#slide5_data$Total1 <- gsub("$", "", slide5_data$Total1, fixed = TRUE)
#slide5_data$OutofPocket <- gsub("$", "", slide5_data$OutofPocket, fixed = TRUE)

#removes all of the ","
#slide5_data$Total1 <- gsub(",", "", slide5_data$Total1, fixed = TRUE)


# tidy_slide5 <- gather(slide5[1:9])
#                     key = "year",
#                     value = "USD",
#                     2:25) %>%
#    rename(State = "Region/state of residence") %>%
#    filter(!is.na(USD)) %>%
#    mutate(Year = as.numeric(year)) %>%
#    select(-(year))
 
# 
# 
# tidy_slide3 <- tidy_slide3 %>%
#   mutate(dollars = as.numeric(USD)) %>%
#   select(-(USD))
# 
# US <- tidy_slide3 %>%
#   filter(State == "United States")
# 
# ggplot(US, aes(Year, dollars)) +
#   geom_line()
# 
# regions <- tidy_slide3 %>%
#   filter(State == "New England" | State == "Mideast" | State == "Great Lakes" |
#            State == "Plains" | State == "Southeast" | State == "Southwest" | 
#            State == "Rocky Mountains" | State == "Far West")
# 
# ggplot(regions, aes(Year, dollars, color = State)) +
#   geom_line()
# 
# states <- tidy_slide3 %>%
#   filter(State == "New York" | State == "Illinois" | State == "Virginia")
# 
# ggplot(states, aes(Year, dollars, color = State)) +
#   geom_line()