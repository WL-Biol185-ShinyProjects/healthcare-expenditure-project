#library imports
library(tidyverse)
library(tidyr)
library(dplyr)
library(readr)
library(ggplot2)

slide5_data <- read_csv("Table 06 Personal Health Care Expenditures.csv")
names(slide5_data) <- lapply(slide5_data[1, ], as.character)

slide5 <- slide5_data[-1,]

#need to get the column names working

#tidy_slide5 <- gather(slide5[1:9])
   #                     key = "year",
   #                     value = "USD",
   #                     2:25) %>%
   # rename(State = "Region/state of residence") %>%
   # filter(!is.na(USD)) %>%
   # mutate(Year = as.numeric(year)) %>%
   # select(-(year))
 
# tidy_slide3$USD <- gsub("$", "", tidy_slide3$USD, fixed = TRUE)
# tidy_slide3$USD <- gsub(",", "", tidy_slide3$USD, fixed = TRUE)
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